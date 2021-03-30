import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noname/commons/constants/theme/theme.dart';
import 'package:noname/commons/utils/lifecycle/lifecycle_manager.dart';
import 'package:noname/navigation/routes.dart';
import 'package:noname/screens/home/home_page.dart';
import 'package:noname/screens/home/widgets/home_page_app_bar.dart';
import 'package:noname/screens/intro_slider/intro_slider.dart';
import 'package:noname/screens/login/login_page.dart';
import 'package:noname/state/providers/auth_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/state/providers/globalProvider.dart';
import 'package:noname/state/providers/theme_provider.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = new GlobalKey();

class MyApp extends StatelessWidget {
  static const PageRoutes pageRoutes = PageRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CoreManager(
      child: Consumer(
          builder: (context, watch, _) {
        ThemeSetting theme = watch(GlobalProvider.themeProvider.state);
        Auth auth = watch(GlobalProvider.authProvider.state);
        print(auth.isAuth);
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
          home:
              AudioServiceWidget(child: auth.isAuth ? HomePage() : LoginPage()),
          routes: pageRoutes.routes,
        );
      } as Widget Function(
              BuildContext, T Function<T>(ProviderBase<Object?, T>), Widget?)),
    );
  }
}
