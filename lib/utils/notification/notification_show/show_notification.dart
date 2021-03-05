import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class ShowNotificationHelper {
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'default_channel', 'Podcast App', 'your channel description',
          color: Colors.white,
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  final IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails();
  final FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  ShowNotificationHelper({this.flutterLocalNotificationsPlugin}) {}

  Future<void> showNotification(message) async {
    int msgId = 1;
    String title = "";
    String body = "";
    String payload = "";

    return await _showNotificationNormal(
      msgId: msgId,
      title: title,
      body: body,
      payload: payload,
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri(path: url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> _showNotificationNormal(
      {required int msgId,
      required String title,
      required String body,
      required String payload,
      String? image}) async {
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: (image != null)
            ? AndroidNotificationDetails('your channel id', 'your channel name',
                'your channel description',
                largeIcon: FilePathAndroidBitmap(
                    await _downloadAndSaveFile(image, 'icon')),
                color: Colors.white,
                importance: Importance.max,
                priority: Priority.max,
                ticker: 'ticker')
            : androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin!
        .show(msgId, title, body, platformChannelSpecifics, payload: payload);
  }
}
