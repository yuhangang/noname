import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:noname/commons/utils/connectivity/connectivity_helper.dart';
import 'package:noname/commons/utils/notification/alert/alert_helper.dart';
import 'package:noname/app.dart';
import 'package:noname/commons/utils/notification/push_notification/push_notification.dart';
import 'package:noname/state/state_observer/user_state_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ConnectivityHelper connectivityHelper = new ConnectivityHelper();
  LocalNotificationHelper.setup();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ProviderScope(child: MyApp(), observers: [UserStateObserver()]));
}
