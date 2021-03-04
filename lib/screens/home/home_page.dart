import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:noname/constants/const_styles.dart';
import 'package:noname/screens/home/channel_screens.dart';
import 'package:noname/screens/home/widgets/home_page_app_bar.dart';
import 'package:noname/screens/home/widgets/podcast_snippet.dart';

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
      backgroundColor: BackgroundColor.mainPageColor,
      appBar: HomePageAppBar(),

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
          PodcastSnippet()
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
