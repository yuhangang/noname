import 'package:flutter/material.dart';
import 'package:noname/commons/constants/theme/custom_themes/customSplashFactory.dart';

abstract class ThemeBuilder {
  static const colorThemeList = [
    //Color(0xFFD8CDB4),
    Color(0xFFEAE7E2),
    //Color(0xFFb0bec5),
    //Color(0xFFFFFFFF),
    //Color(0xFFFCFCFC)
  ];
  static ThemeData buildThemeData(
      {required int themeColorIndex, required bool isDarkMode}) {
    return !isDarkMode
        ? lightTheme(isDarkMode, themeColorIndex)
        : darkTheme(isDarkMode, themeColorIndex);
  }

  static ThemeData lightTheme(bool isDarkMode, int themeColorIndex) {
    return ThemeData(
        primaryColor: Colors.white,
        primaryColorDark: Colors.grey[800],
        accentColor: Colors.grey[400],
        fontFamily: 'Open Sans',
        splashColor: Colors.white,
        canvasColor: Color(0xFFCECBC6),
        dividerTheme: DividerThemeData(
            color: Colors.grey[400], indent: 15, endIndent: 15, space: 0),
        splashFactory: NoSplashFactory(),
        primaryTextTheme: TextTheme(button: TextStyle(color: Colors.grey[800])),
        dialogBackgroundColor: Colors.white,
        dialogTheme: DialogTheme(backgroundColor: Colors.white),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            brightness: Brightness.light,
            titleTextStyle:
                TextStyle(color: Colors.blueGrey[500], fontSize: 25)),
        scaffoldBackgroundColor: colorThemeList[themeColorIndex],
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(color: Colors.white)))),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline5:
              TextStyle(color: Colors.brown[700], fontWeight: FontWeight.w500),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(color: Colors.blueGrey[300]),
            selectedItemColor: Colors.blueGrey[300]),
        sliderTheme: SliderThemeData(
            thumbColor: Colors.white,
            overlayColor: Colors.transparent,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.grey));
  }

  static ThemeData darkTheme(bool isDarkMode, int themeColorIndex) {
    return lightTheme(isDarkMode, themeColorIndex).copyWith(
        canvasColor: Colors.blueAccent[800],
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
        primaryColorDark: Colors.white,
        dialogTheme: DialogTheme(backgroundColor: Colors.grey[800]),
        scaffoldBackgroundColor: Color(0xFF24414E),
        appBarTheme: AppBarTheme(
            color: Colors.transparent,
            brightness: Brightness.dark,
            titleTextStyle:
                TextStyle(color: Colors.blueGrey[100], fontSize: 25)),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(220, 220, 220, 1)),
          headline5: TextStyle(
              color: Color.fromRGBO(200, 200, 255, 1),
              fontWeight: FontWeight.w500),
          headline6: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(220, 220, 220, 1)),
          bodyText1: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(220, 220, 220, 1)),
          bodyText2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
              color: Color.fromRGBO(220, 220, 220, 1)),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            unselectedIconTheme: IconThemeData(color: Colors.grey[200]),
            unselectedItemColor: Colors.grey[200],
            selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
            selectedItemColor: Colors.blueGrey[600]),
        dividerTheme: DividerThemeData(
            color: Colors.grey[600], indent: 15, endIndent: 15, space: 0),
        iconTheme: IconThemeData(color: Colors.white),
        sliderTheme: SliderThemeData(
            thumbColor: Colors.grey[400],
            overlayColor: Colors.transparent,
            activeTrackColor: Colors.blueGrey[500],
            inactiveTrackColor: Colors.grey[400]),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: Colors.white))),
        ));
  }
}
