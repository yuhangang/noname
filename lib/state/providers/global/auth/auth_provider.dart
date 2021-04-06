import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:noname/commons/utils/toast/show_toast.dart';
import 'src/auth_models.dart';
export 'src/auth_models.dart';

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
