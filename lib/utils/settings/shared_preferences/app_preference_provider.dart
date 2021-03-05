

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  bool? isDarkMode;
  Color? colorsTheme;
}

class AppPreferenceProvider extends ChangeNotifier {
  static const String _allowAutoPlayKey = 'is_allow_autoplay';
  static const String _muteInAutoPlayKey = 'mute_in_autoplay';
  static const String _videoAdsSortingMethodKey = 'video_ads_sorting_method';

  bool? _is_allow_autoplay;
  bool? _mute_in_autoplay;

  bool get mute_in_autoplay => _mute_in_autoplay ?? false;
  bool get is_allow_autoplay => _is_allow_autoplay ?? true;

  Future<void> fetchSettings() async {
    var prefs = await SharedPreferences.getInstance();

    _is_allow_autoplay = prefs.getString(_allowAutoPlayKey) == null
        ? true
        : int.parse(prefs.getString(_allowAutoPlayKey)!) == 1
            ? true
            : false;

    _mute_in_autoplay = prefs.getString(_muteInAutoPlayKey) == null
        ? false
        : int.parse(prefs.getString(_muteInAutoPlayKey)!) == 1
            ? true
            : false;
  }

  Future<void> changeAutoPlayPreference(bool val) async {
    print("change autoplay" + val.toString());

    var prefs = await SharedPreferences.getInstance();

    if (val == true) {
      await prefs.setString(_allowAutoPlayKey, '1');
    } else {
      await prefs.setString(_allowAutoPlayKey, '0');
    }
    await fetchSettings();
    print("autoplay changed" + _is_allow_autoplay.toString());
    notifyListeners();
  }

  Future<void> changeMuteInAutoplay(bool val) async {
    print("change mute" + val.toString());
    var prefs = await SharedPreferences.getInstance();

    if (val == true) {
      await prefs.setString(_muteInAutoPlayKey, '1');
    } else {
      await prefs.setString(_muteInAutoPlayKey, '0');
    }
    await fetchSettings();
    print("mute changed" + _mute_in_autoplay.toString());
    notifyListeners();
  }
}
