import 'package:flutter/material.dart';
import 'package:todonote/views/account/account_page.dart';
import 'package:todonote/views/add_todo/add_todo_screen.dart';
import 'package:todonote/views/home/home_page.dart';
import 'package:todonote/views/home/podcast_detail_screen.dart';
import 'package:todonote/views/intro_slider/intro_slider.dart';
import 'package:todonote/views/login/login_page.dart';
import 'package:todonote/views/login/passcode_screen/passcode_screen.dart';
import 'package:todonote/views/login/register_page.dart';
import 'package:todonote/views/search_screen/search_screen.dart';

class PageRoutes {
  const PageRoutes();
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        HomePage.route: (ctx) => HomePage(),
        LoginPage.route: (ctx) => LoginPage(),
        RegisterPage.route: (ctx) => RegisterPage(),
        PodcastDetailPage.route: (ctx) => PodcastDetailPage(),
        IntroPage.route: (ctx) => IntroPage(),
        SearchScreen.route: (ctx) => SearchScreen(),
        AccountPage.route: (ctx) => AccountPage(),
        AddEditTodoScreen.route: (ctx) => AddEditTodoScreen(),
        PasscodeScreen.route: (ctx) => PasscodeScreen()
      };
}
