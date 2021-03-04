import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static void showNoInternetConnectionToast() =>
      showToast("Failed to connect to internet.");
  static void showIncorrectLoginToast() =>
      showToast("Incorrect password or username");

  static void showToast(String text) {
    Fluttertoast.showToast(
        msg: text ?? "NULL VALUE",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Color.fromARGB(255, 30, 30, 30),
        fontSize: 16.0);
  }
}
