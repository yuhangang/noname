import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/commons/utils/toast/show_toast.dart';
import 'src/auth_models.dart';
export 'src/auth_models.dart';

class AuthenticationProvider extends StateNotifier<Auth> {
  AuthenticationProvider(Auth auth) : super(auth);

  Future<bool> login({required String password}) async {
    if (password == '1234') {
      state = Auth(isAuth: true, passcode: state.passcode);
      return true;
    }
    return false;
    //if (userName.length < 4) {
    //  ToastHelper.showToast('Invalid username, minimum 4 characters');
    //  throw "Invalid username, minimum 4 characters";
    //}
    //if (password != '1234') {
    //  ToastHelper.showToast('Incorrect username or password');
    //  throw "Incorrect username or password";
    //}
    //state = Auth(user: User(userEmail: userName));
    //AppPreferenceProvider.saveUserData(state.user!);
  }

  void signOut() {
    state = Auth(isAuth: false, passcode: state.passcode);
    //Navigator.pop(Get.key!.currentState!.context);
  }

  Future<bool> setup(String passcode) async {
    state = Auth(isAuth: state.isAuth, passcode: passcode);
    ToastHelper.showToast('authentication enabled');
    return true;
  }

  Future<bool> remove(String passcode) async {
    if (passcode == state.passcode) {
      state = Auth(isAuth: state.isAuth, passcode: null);
      ToastHelper.showToast('authentication disabled');
      return true;
    }
    return false;
  }

  bool isSamePassword(String s) => state.passcode == s;
}

//  void register(
//      {required String userEmail,
//      required String userName,
//      required String password}) {
//    if (userName.length < 4) {
//      ToastHelper.showToast('Invalid username, minimum 4 characters');
//      return;
//    }
//    if (userName.length < 4) {
//      ToastHelper.showToast('Invalid username, minimum 4 characters');
//      return;
//    }
//    if (!RegExp(
//            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//        .hasMatch(userEmail)) {
//      ToastHelper.showToast('Invalid email format');
//      return;
//    }
//    if (password.length < 4) {
//      ToastHelper.showToast('Password must have minimum 4 characters');
//      return;
//    }
//
//    state = Auth(user: User(userEmail: userEmail, userName: userName));
//    state = Auth(user: User(userEmail: userName));
//  }
//

//
//  void changeUserName(String _) => state.user?.userName = _;
//  void changeUserEmail(String _) => state.user?.userEmail = _;
//}
//
