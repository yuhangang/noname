

import 'package:flutter/material.dart';
import 'package:noname/screens/home/home_page.dart';
import 'package:noname/screens/home/podcast_detail_screen.dart';
import 'package:noname/screens/intro_slider/intro_slider.dart';
import 'package:noname/screens/login/login_page.dart';
import 'package:noname/screens/login/register_page.dart';
import 'package:noname/screens/podcast/podcast_page.dart';
import 'package:noname/screens/search_screen/seach_screen.dart';

class PageRoutes {
  const PageRoutes();
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        HomePage.route: (ctx) => HomePage(),
        LoginPage.route: (ctx) => LoginPage(),
        RegisterPage.route: (ctx) => RegisterPage(),
        PodcastDetailPage.route: (ctx) => PodcastDetailPage(),
        IntroPage.route: (ctx) => IntroPage(),
        SearchScreen.route: (ctx) => SearchScreen()
      };
}
