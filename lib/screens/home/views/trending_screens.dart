import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/screens/home/widgets/discover_tab.dart';
import 'package:noname/screens/podcast/neumorphic_player.dart';
import 'package:noname/screens/widgets/tab_bar.dart';

class TrendingScreen extends StatelessWidget {
  ScrollController listViewScrollController = new ScrollController();

  PageController pageController = PageController();
  GlobalKey<CustomTabBarState> categoryState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (_, index) {
              return Container(
                child: IconButton(
                  icon: Icon(CupertinoIcons.add),
                  onPressed: () {
                    Navigator.of(context).push(
                        CustomPageRoute.verticalTransition(
                            AudioPlayerSample()));
                  },
                ),
              );
            }));
  }
}
