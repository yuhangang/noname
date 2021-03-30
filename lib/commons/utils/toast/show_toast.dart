import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class ToastHelper {
  static void showNoInternetConnectionToast() =>
      showToast("Failed to connect to internet.");
  static void showIncorrectLoginToast() =>
      showToast("Incorrect password or username");

  static void showToast(String text) {
    bool isDarkMode =
        Theme.of(Get.key!.currentState!.context).brightness == Brightness.dark;
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isDarkMode ? Color(0xA84D4D4D) : Color(0xB62B2B2B),
        textColor: Color.fromARGB(255, 245, 245, 245),
        fontSize: 16.0);
  }
}
