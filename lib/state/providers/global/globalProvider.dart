import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:noname/state/providers/global/auth/auth_provider.dart';
import 'package:noname/state/providers/global/todo/achieve_todo_provider.dart';
import 'package:noname/state/providers/global/todo/todo_provider.dart';
import 'package:noname/state/providers/global/theme/theme_provider.dart';
import 'package:noname/state/providers/global/todo/todo_tag_provider.dart';
export 'auth/auth_provider.dart';
export 'todo/todo_provider.dart';
export 'theme/theme_provider.dart';

late final _GlobalProviderInstances instance;

abstract class GlobalProvider {
  // Store the instance of all riverpod provider to be used in global scope
  static Future<void> setup() async {
    instance = new _GlobalProviderInstances();
  }

  static StateNotifierProvider<AuthenticationProvider, Auth> get authProvider =>
      instance.authProvider;

  static StateNotifierProvider<AppTheme, ThemeSetting> get themeProvider =>
      instance.themeProvider;

  static StateNotifierProvider<TodoProvider, TodoList> get todoProvider =>
      instance.todoProvider;

  static StateNotifierProvider<AchievedTodoProvider, TodoList>
      get achievedTodoProvider => instance.achievedTodoProvider;
  static StateNotifierProvider<TodoTagProvider, TodoTagList>
      get todoTagProvider => instance.todoTagProvider;
}

class _GlobalProviderInstances {
  _GlobalProviderInstances() {
    AppPreferenceProvider.fetchSettings().then((value) {
      this.authProvider =
          StateNotifierProvider<AuthenticationProvider, Auth>((ref) {
        return AuthenticationProvider(value);
      });
    });
  }

  late final StateNotifierProvider<AuthenticationProvider, Auth> authProvider;

  final StateNotifierProvider<AppTheme, ThemeSetting> themeProvider =
      StateNotifierProvider<AppTheme, ThemeSetting>((ref) {
    return AppTheme();
  });

  final StateNotifierProvider<TodoProvider, TodoList> todoProvider =
      StateNotifierProvider<TodoProvider, TodoList>((ref) {
    return TodoProvider();
  });

  final StateNotifierProvider<AchievedTodoProvider, TodoList>
      achievedTodoProvider =
      StateNotifierProvider<AchievedTodoProvider, TodoList>((ref) {
    return AchievedTodoProvider();
  });

  final StateNotifierProvider<TodoTagProvider, TodoTagList> todoTagProvider =
      StateNotifierProvider<TodoTagProvider, TodoTagList>((ref) {
    return TodoTagProvider();
  });
}
