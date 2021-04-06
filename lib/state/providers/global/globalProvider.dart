import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:noname/state/providers/global/auth/auth_provider.dart';
import 'package:noname/state/providers/global/todo/todo_provider.dart';
import 'package:noname/state/providers/global/theme/theme_provider.dart';
export 'auth/auth_provider.dart';
export 'todo/todo_provider.dart';
export 'theme/theme_provider.dart';

late final _GlobalProviderInstances instance;

abstract class GlobalProvider {
  // Store the instance of all riverpod provider to be used in global scope
  static Future<void> setup() async {
    User? user;
    await AppPreferenceProvider.fetchSettings().then((value) {
      print(value);
      user = value;
    });
    instance = new _GlobalProviderInstances(user: user);
  }

  static StateNotifierProvider<AuthenticationProvider> get authProvider =>
      instance.authProvider;

  static StateNotifierProvider<AppTheme> get themeProvider =>
      instance.themeProvider;

  static StateNotifierProvider<TodoProvider> get todoProvider =>
      instance.todoProvider;
}

class _GlobalProviderInstances {
  _GlobalProviderInstances({required User? user}) {
    this.authProvider = StateNotifierProvider((ref) {
      return AuthenticationProvider(Auth(user: user));
    });
  }

  late final StateNotifierProvider<AuthenticationProvider> authProvider;

  final StateNotifierProvider<AppTheme> themeProvider =
      StateNotifierProvider((ref) {
    return AppTheme();
  });

  final StateNotifierProvider<TodoProvider> todoProvider =
      StateNotifierProvider((ref) {
    return TodoProvider();
  });
}
