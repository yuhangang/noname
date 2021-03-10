library notification_helper;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:noname/commons/utils/notification/push_notification/src/notification_show/notification_router.dart';
import 'package:noname/commons/utils/notification/push_notification/src/notification_show/show_notification.dart';
import 'package:noname/screens/login/login_page.dart';

late NotificationHelper notificationHelper;

abstract class LocalNotificationHelper {
  static Future<void> setup() async =>
      notificationHelper = NotificationHelper();

  static showLocalNotification({String message = "err"}) {
    notificationHelper.showNotification(message: message);
  }
}

class NotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =
      new AndroidInitializationSettings('icon_notification');
  late InitializationSettings initializationSettings;

  IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();
  late StreamController<String?> selectNotificationSubject;

  Future<void> onSelect(String? data) async =>
      selectNotificationSubject.add(data);
  late ShowNotificationHelper showNotificationHelper;
  final AndroidNotificationChannel channel = AndroidNotificationChannel(
      "trolley_live_consumer_1",
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
      ledColor: Colors.white);

  NotificationHelper() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    selectNotificationSubject = new StreamController<String>();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelect);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    showNotificationHelper = new ShowNotificationHelper(
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);

    selectNotificationSubject.stream.listen((String? payload) async {
      debugPrint('abcd notification payload: ${payload}');
      NotificationNavigationHelper()
          .navigateFromSelect(LoginPage.route, Get.key!.currentContext!);
    });
  }
  void showNotification({required String message}) {
    this.showNotificationHelper.showNotification(message);
  }
}
