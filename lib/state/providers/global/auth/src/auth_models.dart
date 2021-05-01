import 'package:noname/commons/utils/settings/shared_preferences/app_preference_provider.dart';

class Auth {
  //User? user;
  Auth({required this.isAuth, this.passcode, this.useBioMetrics = false}) {
    AppPreferenceProvider.saveUserData(this);
  }
  final bool isAuth;
  final String? passcode;
  final bool useBioMetrics;

  static Auth fromJson(json) {
    return Auth(
        isAuth: json['isAuth'],
        passcode: json['passcode'],
        useBioMetrics: json['useBioMetrics']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['isAuth'] = (this.isRequiredAuthentication) ? false : true;
    json['passcode'] = this.passcode;
    json['useBioMetrics'] = this.useBioMetrics;
    return json;
  }

  bool get isRequiredAuthentication => passcode != null;
}

enum LocalAuthStatus { none, disabled, enabled }

extension LocalAuthStatusExtension on LocalAuthStatus {
  String get itemAsString {
    switch (this) {
      case LocalAuthStatus.none:
        return 'none';
      case LocalAuthStatus.enabled:
        return 'enabled';
      case LocalAuthStatus.disabled:
        return 'disabled';
    }
  }
}

//
//
//class User {
//  final String sId;
//  String? userName;
//  String userEmail;
//  User({this.userName, required this.userEmail, userId})
//      : sId = userId ?? getId();
//
//  User._({this.userName, required this.userEmail, required userId})
//      : sId = userId;
//
//  factory User.fromJson(Map<String, dynamic> json) {
//    return new User._(
//        userEmail: json["user_email"],
//        userName: json["user_name"],
//        userId: json['user_id']!);
//  }
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data["user_email"] = this.userEmail;
//    data["user_name"] = this.userName;
//    data["user_id"] = this.sId;
//    return data;
//  }
//}
