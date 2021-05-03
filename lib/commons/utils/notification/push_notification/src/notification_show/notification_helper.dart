library notification_helper;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:todonote/commons/utils/notification/push_notification/src/notification_show/notification_router.dart';
import 'package:todonote/commons/utils/notification/push_notification/src/notification_show/show_notification.dart';
import 'package:todonote/views/add_todo/widgets/todo_notification_setting.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';

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
      "default_channel_id",
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

  static void removeScheduledNotification(NotificationIdSet info) {
    instance.flutterLocalNotificationsPlugin.cancel(
      info.startTag,
    );
    if (info.endTag != null && info.endTime != null) {
      instance.flutterLocalNotificationsPlugin.cancel(info.endTag!);
    }
  }

  static void showScheduledNotification(NotificationIdSet info) {
    removeScheduledNotification(info);
    instance.showNotificationHelper.showScheduledNotification(
        info.startTime, info.startTag,
        payload: info.todo.id, todo: info.todo);
    if (info.endTag != null && info.endTime != null) {
      instance.showNotificationHelper.showScheduledNotification(
          info.endTime!, info.endTag!,
          payload: info.todo.id, todo: info.todo);
    }
  }
}

class NotificationIdSet {
  late final DateTime startTime;
  late final DateTime? endTime;
  late final int startTag;
  late final int? endTag;
  final TodoTask todo;
  final NotificationTiming notificationTiming;

  NotificationIdSet(
      {required this.todo,
      required this.notificationTiming,
      required DateTime startTime,
      DateTime? endTime}) {
    this.startTime = notificationTiming.adjustedTime(startTime);
    if (endTime != null)
      this.endTime = notificationTiming.adjustedTime(endTime);

    startTag = int.parse(this.todo.id.substring(0, 10));
    endTag =
        (endTime != null) ? int.parse(this.todo.id.substring(0, 10)) + 1 : null;
  }
}
