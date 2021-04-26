import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:noname/views/search_screen/search_screen_tab.dart';
import 'package:noname/views/widgets/categories_tab_bar.dart';

class ChannelScreen extends StatelessWidget {
  ScrollController listViewScrollController = new ScrollController();

  PageController pageController = PageController();
  GlobalKey<CustomTabBarState> categoryState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                categoryState.currentState!.changeCategoryIndex(index);
              },
              children: [
                ScreenScreenTab(),
                ScreenScreenTab(),
              ],
            ),
          ),
          PreferredSize(
            preferredSize: Size(screenWidth, 60),
            child: CategoryTabBar(
              categoryState: categoryState,
              categories: ["All", "Internship"],
              parentPageController: pageController,
            ),
          ),
        ],
      ),
    );
  }
}

/*
TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
 */
