import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './custom_themes/customSplashFactory.dart';

abstract class ThemeBuilder {
  static const colorThemeList = [
    //Color(0xFFD8CDB4),
    Color(0xFFFFFDF5),
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
        colorScheme: ColorScheme.light(
            primary: Color(0xFFF7D158), primaryVariant: Color(0xFF444136)),
        brightness: Brightness.light,
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
            titleTextStyle: TextStyle(
                color: Color(0xFF333333),
                fontSize: 25,
                fontWeight: FontWeight.w400)),
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Color(0xFF4D4A41)),
        scaffoldBackgroundColor: colorThemeList[themeColorIndex],
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(color: Colors.white)))),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline5: GoogleFonts.sourceSansPro().copyWith(
              color: Color(0xFF1414140),
              fontWeight: FontWeight.w400,
              fontSize: 20),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(color: Color(0xFFB49D4F)),
            selectedItemColor: Color(0xFF967C29)),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.grey[200],
        ),
        sliderTheme: SliderThemeData(
            thumbColor: Colors.white,
            overlayColor: Colors.transparent,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.grey));
  }

  static ThemeData darkTheme(bool isDarkMode, int themeColorIndex) {
    return lightTheme(isDarkMode, themeColorIndex).copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.blueGrey[700],
        ),
        colorScheme: ColorScheme.dark(
            primary: Color(0xFF6FC9CF),
            surface: Color(0xFF3A3A3A),
            primaryVariant: Color(0x86FFFFFF)),
        canvasColor: Colors.blueAccent[800],
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
        primaryColorDark: Colors.white,
        dialogTheme: DialogTheme(backgroundColor: Colors.blueGrey[700]),
        scaffoldBackgroundColor: Color(0xFF212F35),
        appBarTheme: AppBarTheme(
            color: Colors.transparent,
            brightness: Brightness.dark,
            titleTextStyle:
                TextStyle(color: Colors.blueGrey[100], fontSize: 25)),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
          color: Color(0xFFB9B9B9),
        )),
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Color(0xFFB8709C)),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(220, 220, 220, 1)),
          headline5: GoogleFonts.sourceSansPro().copyWith(
              color: Color(0xFFE4E4E4),
              fontWeight: FontWeight.w400,
              fontSize: 20),
          bodyText1: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
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
            selectedIconTheme: IconThemeData(color: Color(0xFF6ECFD6)),
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
                  TextStyle(color: Color(0xFFFFFFFF)))),
        ),
        buttonTheme: ButtonThemeData(
            padding: const EdgeInsets.all(0),
            textTheme: ButtonTextTheme.normal,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap));
  }
}
