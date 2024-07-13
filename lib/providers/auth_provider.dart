import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/google_account_user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late SharedPreferences? _prefs;
  late bool isLoggedIn = false;
  late GoogleAccountUserModel? userObj;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  AuthProvider() {
    _getSharedPreferences();
  }

  Future<void> _getSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    isLoggedIn = _prefs?.getBool('isLoggedIn') ?? false;
    String? stringUser = _prefs?.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> jsonUser = jsonDecode(stringUser);
      userObj = GoogleAccountUserModel.fromJson(jsonUser);
    }
    notifyListeners();
  }

  Future<void> login() async {
    try {
      final GoogleSignInAccount? userData = await googleSignIn.signIn();

      if (userData != null) {
        GoogleAccountUserModel userAccount =
            GoogleAccountUserModel.fromGoogleSignInAccount(userData);

        userObj = userAccount;
        isLoggedIn = true;
        _prefs?.setString('user', jsonEncode(userAccount.toJson()));
        _prefs?.setBool('isLoggedIn', true);

        notifyListeners();
      }
    } catch (error) {
      // print('Error on login $error');
    }
  }

  Future<void> logout() async {
    if (userObj != null) {
      await googleSignIn.signOut();
      userObj = null;
      isLoggedIn = false;
      _prefs?.remove('user');
      _prefs?.remove('isLoggedIn');
      notifyListeners();
    }
  }
}
