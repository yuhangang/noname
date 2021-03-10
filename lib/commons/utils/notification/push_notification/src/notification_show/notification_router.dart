import 'package:flutter/material.dart';
import 'package:noname/screens/home/home_page.dart';
import 'package:noname/screens/login/login_page.dart';

class NotificationNavigationHelper {
  Future<void> navigateFromSelect(String routeName, BuildContext context,
      {String? payload}) async {
    if (payload == null) {
      switch (routeName) {
        case LoginPage.route:
          await _handleHomePage(context);
          break;
        default:
          throw 'route not implemented';
          break;
      }
    }
  }

  static _handleHomePage(BuildContext context) {
    Navigator.pushNamed(context, LoginPage.route);
  }
}
