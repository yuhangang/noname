import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/screens/account/account_page.dart';
import 'package:noname/screens/home/channel_screens.dart';
import 'package:noname/screens/home/widgets/home_page_app_bar.dart';
import 'package:noname/screens/home/widgets/podcast_snippet.dart';
import 'package:noname/screens/search_screen/seach_screen.dart';
import 'package:noname/widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  static const route = "/home-page";
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          iconSize: 30,
          splashRadius: 25,
          padding: const EdgeInsets.all(10),
          onPressed: () {
            Navigator.of(context)
                .push(CustomPageRoute.verticalTransition(SearchScreen()));
          },
          icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "UTHOPIA",
                style: Theme.of(context)
                    .appBarTheme
                    .titleTextStyle!
                    .copyWith(fontSize: 24),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AccountPage.route);
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://miro.medium.com/max/700/1*InbuykHMMQcVkNSC_uNp0A.png",
                  ),
                  radius: 15,
                  backgroundColor:
                      SchedulerBinding.instance!.window.platformBrightness ==
                              Brightness.light
                          ? Colors.grey[100]
                          : Colors.grey[800],
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),

      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ChannelScreen())
                  //NeumorphicBar(
                  //  height: 400,
                  //  width: 30,
                  //  text: "volume",
                  //  value: 10,
                  //  linearGradient: LinearGradient(
                  //      colors: [Colors.white, Colors.grey[200]],
                  //      begin: Alignment.topCenter,
                  //      end: Alignment.bottomCenter),
                  //)
                ],
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
