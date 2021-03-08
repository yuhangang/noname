import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/constants/theme/theme.dart';

final themeProvider = StateNotifierProvider((ref) {
  return AppTheme();
});

class AppTheme extends StateNotifier<ThemeSetting> {
  AppTheme() : super(new ThemeSetting());
  void switchDarkLightMode(bool val) {
    state =
        ThemeSetting(isDarkMode: val, colorThemeIndex: state.colorThemeIndex);
  }

  void setThemeColorIndex(int colorIndex) {
    state =
        ThemeSetting(isDarkMode: state.isDarkMode, colorThemeIndex: colorIndex);
  }
}

class ThemeSetting {
  bool isDarkMode;
  int colorThemeIndex;

  ThemeSetting({this.isDarkMode = false, this.colorThemeIndex = 0});

  ThemeData getTheme({bool? isSystemDarkMode}) => ThemeBuilder.buildThemeData(
      themeColorIndex: this.colorThemeIndex,
      isDarkMode: isSystemDarkMode ?? this.isDarkMode);
}
