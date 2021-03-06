import 'package:flutter/material.dart';
import 'package:noname/commons/constants/theme/custom_themes/customSplashFactory.dart';

abstract class ThemeBuilder {
  static ThemeData buildThemeData() {
    return ThemeData(
      primaryColor: Colors.white,
      accentColor: Colors.grey[400],
      fontFamily: 'Open Sans',
      splashColor: Colors.white,
      splashFactory: NoSplashFactory(),
      primaryTextTheme: TextTheme(button: TextStyle(color: Colors.grey[800])),
      scaffoldBackgroundColor: Colors.blueGrey[100],
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: Colors.white)))),
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
    );
  }
}
