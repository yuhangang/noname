import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noname/state/providers/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  bool? isDarkMode;
  Color? colorsTheme;
}

class AppPreferenceProvider extends ChangeNotifier {
  static const String _authentication = 'authentication';

  Future<User?> fetchSettings1() async {
    var prefs = await SharedPreferences.getInstance();
    User? user = ;
    try {
      return User.fromJson(jsonDecode(prefs.getString('authentication') ?? ""));
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUserData(User userData) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authentication, jsonEncode(userData.toJson()));
  }

  Future<void> removeUserData() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authentication, "");
  }
}
