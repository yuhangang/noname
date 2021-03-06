import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider((ref) {
  return Counter();
});

class Counter extends StateNotifier<Auth> {
  bool isAuth = false;
  Counter() : super(new Auth(user: User(userName: "", userEmail: "")));
  void login() => this.isAuth = true;
  void changeUserName(String _) => state.user?.userName = _;
  void changeUserEmail(String _) => state.user?.userEmail = _;
}

class Auth {
  User? user;
  Auth({user});
}

String getId() => "fergef";

class User {
  final String sId;
  String userName;
  String userEmail;
  User({@required this.userName = "", @required this.userEmail = "", userId})
      : sId = userId ?? getId();

  User._(
      {@required this.userName = "",
      @required this.userEmail = "",
      @required userId})
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
