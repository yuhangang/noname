import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todonote/state/providers/global/auth/auth_provider.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';

import 'package:todonote/state/providers/global/todo/src/todo_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  bool? isDarkMode;
  Color? colorsTheme;
}

abstract class AppPreferenceProvider extends ChangeNotifier {
  static const String _authentication = 'authentication';
  static const String _todoList = 'todoList';
  static const String _todoListAchieved = 'todoListAchieved';
  static const String _todoTags = 'todoTags';
  static const String _isFirstRun = 'isFirstRun';
  static const String _theme = 'theme';
  static Future<Auth> fetchSettings() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      return Auth.fromJson(jsonDecode(prefs.getString(_authentication) ?? ""));
    } catch (e) {
      return Auth(isAuth: true);
    }
  }

  static Future<ThemeSetting> fetchThemeSetting() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      return ThemeSetting.fromJson(jsonDecode(prefs.getString(_theme)!));
    } catch (e) {
      return ThemeSetting();
    }
  }

  static Future<void> saveThemeSetting(ThemeSetting value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_theme, jsonEncode(value.toJson()));
  }

  static Future<void> saveUserData(Auth userData) async {
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

  static Future<void> saveAchievedTodoList(List<TodoTask> todos) async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString(
        _todoListAchieved, jsonEncode(todos.map((e) => e.toJson()).toList()));
  }

  static Future<void> removeAchievedTodoList() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_todoListAchieved, '');
  }

  static Future<List<TodoTask>> fetchAchievedTodos() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      return List<TodoTask>.from(
          jsonDecode(prefs.getString(_todoListAchieved) ?? "")
              .map((e) => TodoTask.fromJson(e)));
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<List<TodoTask>> fetchTodos() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      debugPrint(List<TodoTask>.from(
          jsonDecode(prefs.getString(_todoList) ?? "")
              .map((e) => TodoTask.fromJson(e))).toString());
      return List<TodoTask>.from(jsonDecode(prefs.getString(_todoList) ?? "")
          .map((e) => TodoTask.fromJson(e)));
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<void> saveTodoTagList(List<TodoTag> todos) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _todoTags, jsonEncode(todos.map((e) => e.toJson()).toList()));
  }

  static Future<List<TodoTag>> fetchTodoTags() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      return List<TodoTag>.from(jsonDecode(prefs.getString(_todoTags) ?? "")
          .map((e) => TodoTag.fromJson(e)));
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<bool> isFirstRun() async {
    var prefs = await SharedPreferences.getInstance();
    String? isFirstRun = await prefs.getString(_isFirstRun);
    if (isFirstRun != null) return false;
    await prefs.setString(_isFirstRun, '1');
    return true;
  }
}
