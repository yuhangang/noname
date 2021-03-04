import 'package:flutter/material.dart';
import 'package:noname/screens/intro_slider/intro_slider.dart';
import 'main/routes.dart';
import 'package:noname/main/routes.dart';
import 'package:noname/providers/counter.dart';
import 'package:noname/screens/login/login_page.dart';
import 'package:noname/styles/customSplashFactory.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = new GlobalKey();

class MyApp extends StatelessWidget {
  static const PageRoutes pageRoutes = PageRoutes();
  GlobalKey<NavigatorState> navigationKey;
  MyApp({@required this.navigationKey});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));

    return Consumer(builder: (context, watch, _) {
      final count = watch(counterProvider.state);
      return MaterialApp(
        navigatorKey: navigationKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.grey[400],
          fontFamily: 'Open Sans',
          splashColor: Colors.white,
          splashFactory: NoSplashFactory(),
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        initialRoute: IntroPage.route,
        routes: pageRoutes.routes,
      );
    });
  }
}
