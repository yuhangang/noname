

import 'dart:async';
import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:noname/utils/notification/notification_show/show_notification.dart';

class LocalNotificationHelper {
  ShowNotificationHelper? showNotificationHelper;

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "trolley_live_consumer_1",
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    enableVibration: true,
    playSound: true,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('icon_notif');
  var initializationSettingsIOS = IOSInitializationSettings();
  late StreamController<String?> _selectNotificationSubject;

  Future<void> onSelect(String? data) async =>
      _selectNotificationSubject.add(data);

  setup() {
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelect);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    showNotificationHelper = new ShowNotificationHelper(
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
    _selectNotificationSubject.stream.listen((String? payload) async {
      print('abcd notification payload: ${jsonDecode(payload!)}');
    });
  }
}
