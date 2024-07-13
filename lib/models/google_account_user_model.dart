import 'package:google_sign_in/google_sign_in.dart';

class GoogleAccountUserModel {
  final String? displayName;
  final String email;
  final String id;
  final String? photoUrl;
  final String? serverAuthCode;

  GoogleAccountUserModel(
      {required this.displayName,
      required this.email,
      required this.id,
      required this.photoUrl,
      required this.serverAuthCode});

  factory GoogleAccountUserModel.fromGoogleSignInAccount(
      GoogleSignInAccount account) {
    return GoogleAccountUserModel(
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

  factory GoogleAccountUserModel.fromJson(Map<String, dynamic> json) {
    return GoogleAccountUserModel(
        displayName: json['displayName'],
        email: json['email'],
        id: json['id'],
        photoUrl: json['photoUrl'],
        serverAuthCode: json['serverAuthCode']);
  }
}
