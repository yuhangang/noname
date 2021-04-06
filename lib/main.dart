import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/utils/connectivity/connectivity_helper.dart';
import 'package:noname/app.dart';
import 'package:noname/commons/utils/notification/push_notification/push_notification.dart';
import 'package:noname/commons/utils/uuid/uuid_generator.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/state_observer/user_state_observer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait(
      [GlobalProvider.setup(), nonWebSetup(), UUidGenerator.setup()]);

  ConnectivityHelper connectivityHelper = new ConnectivityHelper();

  runApp(ProviderScope(child: MyApp(), observers: [UserStateObserver()]));
}

Future<void> nonWebSetup() async {
  if (!kIsWeb) {
    await LocalNotificationHelper.setup();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
