import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/commons/constants/theme/theme.dart';
import 'package:todonote/commons/utils/settings/shared_preferences/app_preference_provider.dart';

class AppTheme extends StateNotifier<ThemeSetting> {
  AppTheme(ThemeSetting setting) : super(setting);
  void switchDarkLightMode(bool val) {
    state =
        ThemeSetting(isDarkMode: val, colorThemeIndex: state.colorThemeIndex);
    AppPreferenceProvider.saveThemeSetting(state);
  }

  void setThemeColorIndex(int colorIndex) {
    state =
        ThemeSetting(isDarkMode: state.isDarkMode, colorThemeIndex: colorIndex);
    AppPreferenceProvider.saveThemeSetting(state);
  }
}

class ThemeSetting {
  bool isDarkMode;
  int colorThemeIndex;

  ThemeSetting({this.isDarkMode = false, this.colorThemeIndex = 0});

  ThemeData getTheme({bool? isSystemDarkMode}) => ThemeBuilder.buildThemeData(
      themeColorIndex: this.colorThemeIndex,
      isDarkMode: isSystemDarkMode ?? this.isDarkMode);

  static ThemeSetting fromJson(Map<String, dynamic> json) {
    return ThemeSetting(
        isDarkMode: json['is_dark_mode'],
        colorThemeIndex: json['color_theme_index']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["is_dark_mode"] = this.isDarkMode;
    json["color_theme_index"] = this.colorThemeIndex;
    return json;
  }
}
