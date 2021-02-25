import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider((ref) {
  return Counter();
});

class Counter extends StateNotifier<Auth> {
  Counter() : super(new Auth());

  void changeUserName(String _) => state.userName = _;
  void changeUserEmail(String _) => state.userEmail = _;
}

class Auth {
  String userName;
  String userEmail;
}
