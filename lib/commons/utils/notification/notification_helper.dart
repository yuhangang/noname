library notification_helper;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:noname/commons/utils/notification/notification_router.dart';
import 'package:noname/commons/utils/notification/notification_show/show_notification.dart';
import 'package:noname/screens/login/login_page.dart';

abstract class LocalNotificationHelper {
  static Future<void> setup(GlobalKey<NavigatorState> naviKey) async =>
      setupNotification(naviKey);
  static showNotification({String message = "err"}) {
    showNotificationHelper.showNotification(message);
  }
}

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final AndroidInitializationSettings _initializationSettingsAndroid =
    new AndroidInitializationSettings('icon_notification');
final InitializationSettings _initializationSettings = InitializationSettings(
    android: _initializationSettingsAndroid, iOS: _initializationSettingsIOS);

IOSInitializationSettings _initializationSettingsIOS =
    IOSInitializationSettings();
late StreamController<String?> _selectNotificationSubject;

Future<void> onSelect(String? data) async =>
    _selectNotificationSubject.add(data);
late ShowNotificationHelper showNotificationHelper;
final AndroidNotificationChannel _channel = AndroidNotificationChannel(
    "trolley_live_consumer_1",
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    enableVibration: true,
    playSound: true,
    ledColor: Colors.white);

void setupNotification(GlobalKey<NavigatorState> naviKey) {
  _selectNotificationSubject = new StreamController<String>();

  _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
      onSelectNotification: onSelect);
  _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);

  showNotificationHelper = new ShowNotificationHelper(
      flutterLocalNotificationsPlugin: _flutterLocalNotificationsPlugin);

  _selectNotificationSubject.stream.listen((String? payload) async {
    debugPrint('abcd notification payload: ${payload}');
    NotificationNavigationHelper()
        .navigateFromSelect(LoginPage.route, naviKey.currentContext!);
  });
}
