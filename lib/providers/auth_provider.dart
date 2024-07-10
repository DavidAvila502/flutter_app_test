import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  late GoogleSignInAccount? userObj;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void login(context) {
    googleSignIn.signIn().then((userData) {
      if (userData != null) {
        userObj = userData;
        isLoggedIn = true;
        notifyListeners();
      }
    }).catchError((onError) {});
  }

  void logout(context) {
    if (googleSignIn.currentUser != null) {
      googleSignIn.signOut().then((onValue) {
        userObj = null;
        isLoggedIn = false;
        notifyListeners();
      });
    }
  }
}
