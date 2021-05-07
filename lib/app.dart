import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todonote/commons/utils/lifecycle/lifecycle_manager.dart';
import 'package:todonote/navigation/routes.dart';
import 'package:todonote/views/home/home_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/views/intro_slider/intro_slider.dart';

import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/views/login/passcode_screen/passcode_screen.dart';

import 'navigation/custom_page_route/custom_page_route.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = new GlobalKey();

class MyApp extends StatelessWidget {
  final bool isFirstRun;
  MyApp({required this.isFirstRun});
  static const PageRoutes pageRoutes = PageRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CoreManager(
      child: Consumer(builder: (context, watch, child) {
        ThemeSetting theme = watch(GlobalProvider.themeProvider);
        Auth auth = watch(GlobalProvider.authProvider);

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark));
        if (!auth.isAuth && !this.isFirstRun) {
          Future.delayed(
              Duration.zero,
              () => Navigator.of(Get.key!.currentState!.context)
                  .pushReplacement(CustomPageRoute.verticalTransition(
                      PasscodeScreen(),
                      animationDuration: Duration(milliseconds: 800))));
        }

        return MaterialApp(
          navigatorKey: Get.key,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme.getTheme(),
          darkTheme: theme.getTheme(isSystemDarkMode: true),
          home: this.isFirstRun ? IntroPage() : HomePage(),
          routes: pageRoutes.routes,
        );
      }),
    );
  }
}
