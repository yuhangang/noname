import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/screens/account/account_page.dart';
import 'package:noname/screens/search_screen/channel_screens.dart';
import 'package:noname/screens/home/views/trending_screens.dart';
import 'package:noname/screens/home/widgets/animated_bottom_nav.dart';
import 'package:noname/screens/home/widgets/home_page_app_bar.dart';
import 'package:noname/screens/home/widgets/podcast_snippet.dart';
import 'package:noname/screens/search_screen/seach_screen.dart';
import 'package:noname/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  static const route = "/home-page";

  static CustomAppBar homePageAppbar(BuildContext context,
          {required String title}) =>
      CustomAppBar(
        title: title,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(CustomPageRoute.verticalTransition(SearchScreen()));
          },
          icon: Icon(
            CupertinoIcons.search,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                    CupertinoIcons.settings,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AccountPage.route);
                  }),
            ],
          )
        ],
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final bottomnavigationkey = GlobalKey();
  int index = 0;

  PageController pageController = new PageController();
  late AnimationController bottomNaviController;
  late Animation<double> animation;
  bool isAnimatedHide = false;
  bool isAnimatedShow = false;

  final List<Widget> childPage = [
    TrendingScreen(),
    TrendingScreen(),
    Container(
      child: Center(child: Text("ssf")),
    ),
    Container(
      child: Center(child: Text("ssf")),
    ),
    Container(
      child: Center(child: Text("ssf")),
    ),
  ];

  static const List<String> titles = [
    'Dashboard',
    'Trending',
    "Page 3",
    "Page 4",
    "Account"
  ];

  @override
  void initState() {
    bottomNaviController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    bottomNaviController.forward();
    super.initState();
  }

  @override
  void dispose() {
    bottomNaviController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<UserScrollNotification>(
            onNotification: handleScrollActivityDetected,
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: childPage,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedBottomNaviBar(
                bottomNaviController: bottomNaviController,
                bottomnavigationkey: bottomnavigationkey,
                index: index,
                onTapItem: (_) {
                  if (_ == index) return;
                  setState(() {
                    index = _;
                    pageController.jumpToPage(_);
                    //if ((_ - index).abs() > 1) {
                    //  index = _;
                    //  pageController.jumpToPage(_);
                    //} else {
                    //  index = _;
                    //  pageController.animateToPage(_,
                    //      duration: const Duration(milliseconds: 400),
                    //      curve: Curves.easeOut);
                    //}
                  });
                },
              ),
            ],
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool handleScrollActivityDetected(UserScrollNotification notification) {
    if ((notification.metrics is PageMetrics)) return true;

    if (notification.direction == ScrollDirection.forward && !isAnimatedShow) {
      isAnimatedHide = false;
      isAnimatedShow = true;

      bottomNaviController.forward();
    } else if (notification.direction == ScrollDirection.reverse &&
        !isAnimatedHide) {
      isAnimatedHide = true;
      isAnimatedShow = false;

      bottomNaviController.reverse();
    }

    //if (notification.direction == ScrollDirection.forward) {
    //  bottomNaviController.forward();
    //}
    //if (notification.direction == ScrollDirection.reverse) {
    //  bottomNaviController.reverse();
    //}
    return true;
  }
}
