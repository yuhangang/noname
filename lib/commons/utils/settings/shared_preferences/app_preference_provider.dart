import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noname/state/providers/global/auth/auth_provider.dart';

import 'package:noname/state/providers/global/todo/src/todo_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  bool? isDarkMode;
  Color? colorsTheme;
}

abstract class AppPreferenceProvider extends ChangeNotifier {
  static const String _authentication = 'authentication';
  static const String _todoList = 'todoList';

  static Future<User?> fetchSettings() async {
    var prefs = await SharedPreferences.getInstance();

    try {
      return User.fromJson(jsonDecode(prefs.getString(_authentication) ?? ""));
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveUserData(User userData) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authentication, jsonEncode(userData.toJson()));
  }

  static Future<void> removeUserData() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authentication, "");
  }

  static Future<void> saveTodoList(List<TodoTask> todos) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _todoList, jsonEncode(todos.map((e) => e.toJson()).toList()));
  }

  static Future<List<TodoTask>> fetchTodos() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      return List<TodoTask>.from(jsonDecode(prefs.getString(_todoList) ?? "")
          .map((e) => TodoTask.fromJson(e)));
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
