import 'package:flutter/material.dart';
import 'package:noname/commons/constants/theme/theme.dart';
import 'package:noname/navigation/routes.dart';
import 'package:noname/screens/intro_slider/intro_slider.dart';
import 'package:noname/state/providers/counter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = new GlobalKey();

class MyApp extends StatelessWidget {
  static const PageRoutes pageRoutes = PageRoutes();
  GlobalKey<NavigatorState> navigationKey;
  MyApp({required this.navigationKey});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));

    return Consumer(
        builder: (context, watch, _) {
      final count = watch(counterProvider.state);
      return MaterialApp(
        navigatorKey: navigationKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeBuilder.buildThemeData(),
        initialRoute: IntroPage.route,
        routes: pageRoutes.routes,
      );
    } as Widget Function(
            BuildContext, T Function<T>(ProviderBase<Object?, T>), Widget?));
  }
}
