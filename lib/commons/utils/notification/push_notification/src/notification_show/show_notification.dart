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
          largeIcon: const DrawableResourceAndroidBitmap('ic_logo_white_t'),
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

  Future<void> _showNotificationNormal(
      {required int msgId,
      required String title,
      required String body,
      required String payload,
      String? image}) async {
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: (image != null)
            ? AndroidNotificationDetails('default_channel', 'your channel name',
                'your channel description',
                color: Colors.white,
                importance: Importance.max,
                priority: Priority.max,
                ticker: 'ticker')
            : androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin!
        .show(msgId, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(
        Uri.https('iconspng.com', 'images/king-george-vi/king-george-vi.jpg'));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    print("download file");
    return filePath;
  }

  Future<void> showOngoingNotification(
      {required String message, required String imageUrl}) async {
    final String largeIconPath = await _downloadAndSaveFile(
        'https://pbs.twimg.com/media/Et0-AVoXUAAsHab?format=png&name=4096x4096',
        'largeIcon');
    // this person object will use an icon that was downloaded
    final Person lunchBot = Person(
      name: 'Lunch bot',
      key: 'bot',
      bot: true,
      icon: BitmapFilePathAndroidIcon(largeIconPath),
    );

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(largeIconPath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: 'overridden <b>big</b> content title',
            htmlFormatContentTitle: true,
            summaryText: 'summary <i>text</i>',
            htmlFormatSummaryText: true);

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'default_channel', 'your channel name', 'your channel description',
            tag: "ongoing broadcast",
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation,
            ongoing: true,
            ticker: "dsfew",
            autoCancel: false);
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
        123,
        'ongoing notification title',
        'ongoing notification body',
        platformChannelSpecifics);
  }
}
