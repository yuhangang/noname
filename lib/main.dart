import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/utils/connectivity/connectivity_helper.dart';
import 'package:noname/commons/utils/notification/alert/alert_helper.dart';
import 'package:noname/app.dart';
import 'package:noname/commons/utils/notification/notification_helper.dart';
import 'package:noname/state/state_observer/user_state_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalKey<NavigatorState> naviKey = new GlobalKey();
  ConnectivityHelper connectivityHelper = new ConnectivityHelper();
  AlertDialogHelper.init(navigationKey: naviKey);
  LocalNotificationHelper.setup(naviKey);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ProviderScope(
      child: MyApp(
        navigationKey: naviKey,
      ),
      observers: [UserStateObserver()]));
}
