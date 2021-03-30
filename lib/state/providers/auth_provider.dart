import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:noname/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:noname/commons/utils/toast/show_toast.dart';

class AuthenticationProvider extends StateNotifier<Auth> {
  AuthenticationProvider(Auth auth) : super(auth);

  Future<void> login(
      {required String userName, required String password}) async {
    if (userName.length < 4) {
      ToastHelper.showToast('Invalid username, minimum 4 characters');
      return;
    }
    if (password != '1234') {
      ToastHelper.showToast('Incorrect username or password');
      return;
    }
    state = Auth(user: User(userEmail: userName));
    AppPreferenceProvider.saveUserData(state.user!);
  }

  void register(
      {required String userEmail,
      required String userName,
      required String password}) {
    if (userName.length < 4) {
      ToastHelper.showToast('Invalid username, minimum 4 characters');
      return;
    }
    if (userName.length < 4) {
      ToastHelper.showToast('Invalid username, minimum 4 characters');
      return;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(userEmail)) {
      ToastHelper.showToast('Invalid email format');
      return;
    }
    if (password.length < 4) {
      ToastHelper.showToast('Password must have minimum 4 characters');
      return;
    }

    state = Auth(user: User(userEmail: userEmail, userName: userName));
    state = Auth(user: User(userEmail: userName));
  }

  void signOut() {
    state = Auth(user: null);
    AppPreferenceProvider.removeUserData();
    //Navigator.pop(Get.key!.currentState!.context);
  }

  void changeUserName(String _) => state.user?.userName = _;
  void changeUserEmail(String _) => state.user?.userEmail = _;
}

class Auth {
  User? user;
  Auth({this.user});
  bool get isAuth => user != null;
}

String getId() => "fergef";

class User {
  final String sId;
  String? userName;
  String userEmail;
  User({this.userName, required this.userEmail, userId})
      : sId = userId ?? getId();

  User._({this.userName, required this.userEmail, required userId})
      : sId = userId;

  factory User.fromJson(Map<String, dynamic> json) {
    return new User._(
        userEmail: json["user_email"],
        userName: json["user_name"],
        userId: json['user_id']!);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["user_email"] = this.userEmail;
    data["user_name"] = this.userName;
    data["user_id"] = this.sId;
    return data;
  }
}
