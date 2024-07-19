import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

GoogleAccountUser? googleAccountUserFromJson(String str) =>
    GoogleAccountUser.fromJson(jsonDecode(str));

String googleAccountUserToJson(GoogleAccountUser? user) =>
    jsonEncode(user!.toJson());

GoogleAccountUser googleAccountUserFromGoogleSigInAccount(
        GoogleSignInAccount user) =>
    GoogleAccountUser.fromGoogleSignInAccount(user);

class GoogleAccountUser {
  final String? displayName;
  final String email;
  final String id;
  final String? photoUrl;
  final String? serverAuthCode;

  GoogleAccountUser(
      {required this.displayName,
      required this.email,
      required this.id,
      required this.photoUrl,
      required this.serverAuthCode});

  factory GoogleAccountUser.fromGoogleSignInAccount(
      GoogleSignInAccount account) {
    return GoogleAccountUser(
        displayName: account.displayName,
        email: account.email,
        id: account.id,
        photoUrl: account.photoUrl,
        serverAuthCode: account.serverAuthCode);
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'id': id,
      'photoUrl': photoUrl
    };
  }

  factory GoogleAccountUser.fromJson(Map<String, dynamic> json) {
    return GoogleAccountUser(
        displayName: json['displayName'],
        email: json['email'],
        id: json['id'],
        photoUrl: json['photoUrl'],
        serverAuthCode: json['serverAuthCode']);
  }
}
