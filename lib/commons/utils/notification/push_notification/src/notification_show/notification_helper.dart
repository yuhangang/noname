library notification_helper;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:noname/commons/utils/notification/push_notification/src/notification_show/notification_router.dart';
import 'package:noname/commons/utils/notification/push_notification/src/notification_show/show_notification.dart';
import 'package:noname/views/add_todo/widgets/todo_notification_setting.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jiffy/src/enums/units.dart';

class LocalNotificationHelper {
  static final LocalNotificationHelper instance =
      LocalNotificationHelper._privateConstructor();

  LocalNotificationHelper._privateConstructor() {
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
      //NotificationNavigationHelper()
      //    .navigateFromSelect(LoginPage.route, Get.key!.currentContext!);
      await flutterLocalNotificationsPlugin.cancel(123,
          tag: 'ongoing broadcast');
    });
  }

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

  static void showNotification({required String message}) {
    instance.showNotificationHelper.showNotification(message);
  }

  static void showOngoingNotification(
      {required String message, required String imageUrl}) {
    instance.showNotificationHelper
        .showOngoingNotification(message: message, imageUrl: imageUrl);
  }

  static void showScheduledNotification(NotificationIdSet info) {
    instance.flutterLocalNotificationsPlugin.cancel(
      info.startTag,
    );
    instance.showNotificationHelper.showScheduledNotification(
        info.startTime, info.startTag,
        payload: info.todoId);
    if (info.endTag != null && info.endTime != null) {
      instance.flutterLocalNotificationsPlugin.cancel(info.endTag!);
      instance.showNotificationHelper.showScheduledNotification(
          info.endTime!, info.endTag!,
          payload: info.todoId);
    }
  }
}

class NotificationIdSet {
  late final DateTime startTime;
  late final DateTime? endTime;
  late final int startTag;
  late final int? endTag;
  final String todoId;
  final NotificationTiming notificationTiming;

  NotificationIdSet(
      {required this.todoId,
      required this.notificationTiming,
      required DateTime startTime,
      DateTime? endTime}) {
    this.startTime = notificationTiming.adjustedTime(startTime);
    if (endTime != null)
      this.endTime = notificationTiming.adjustedTime(endTime);

    startTag = int.parse(this.todoId.substring(0, 10));
    endTag =
        (endTime != null) ? int.parse(this.todoId.substring(0, 10)) + 1 : null;
  }
}
