import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noname/commons/constants/theme/theme.dart';
import 'package:noname/commons/utils/lifecycle/lifecycle_manager.dart';
import 'package:noname/navigation/routes.dart';
import 'package:noname/screens/intro_slider/intro_slider.dart';
import 'package:noname/state/providers/counter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/state/providers/theme_setting.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = new GlobalKey();

class MyApp extends StatelessWidget {
  static const PageRoutes pageRoutes = PageRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CoreManager(
      child: Consumer(
          builder: (context, watch, _) {
        ThemeSetting theme = watch(themeProvider.state);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
        return MaterialApp(
          navigatorKey: Get.key,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme.getTheme(),
          darkTheme: theme.getTheme(isSystemDarkMode: true),
          initialRoute: IntroPage.route,
          routes: pageRoutes.routes,
        );
      } as Widget Function(
              BuildContext, T Function<T>(ProviderBase<Object?, T>), Widget?)),
    );
  }
}
