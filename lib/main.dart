import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/commons/utils/connectivity/connectivity_helper.dart';
import 'package:todonote/app.dart';
import 'package:todonote/commons/utils/notification/push_notification/push_notification.dart';
import 'package:todonote/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:todonote/commons/utils/uuid/uuid_generator.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/state_observer/user_state_observer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isFirstRun = await AppPreferenceProvider.isFirstRun();
  await Future.wait([
    GlobalProvider.setup(),
    nonWebSetup(),
    AppPreferenceProvider.isFirstRun()
  ]).then((value) => null);

  ConnectivityHelper connectivityHelper = new ConnectivityHelper();

  runApp(ProviderScope(
      child: MyApp(
        isFirstRun: isFirstRun,
      ),
      observers: [UserStateObserver()]));
}

Future<void> nonWebSetup() async {
  if (!kIsWeb) {
    //await SystemChrome.setPreferredOrientations([
    //  DeviceOrientation.portraitUp,
    //  DeviceOrientation.portraitDown,
    //]);
  }
}
