import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/views/account/account_page.dart';
import 'package:noname/views/add_todo/add_todo_screen.dart';
import 'package:noname/views/home/dashboard/dashboard_screens.dart';
import 'package:noname/views/home/widgets/animated_bottom_nav.dart';
import 'package:noname/views/widgets/small_fab.dart';
import 'package:noname/views/workspaces_screen/workspaces_screen.dart';
import 'package:noname/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  static const route = "/home-page";

  static CustomAppBar homePageAppbar(BuildContext context,
          {required String title}) =>
      CustomAppBar(
        title: title,
        leading: null,
        //leading: CustomIconButton(
        //  onPressed: () {
        //    Navigator.of(context)
        //        .push(CustomPageRoute.verticalTransition(SearchScreen()));
        //  },
        //  icon: CupertinoIcons.search,
        //),
        actions: [],
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
    DashBoardScreen(),
    WorkSpacesScreen(),
    AccountPage()
  ];

  static const List<String> titles = ['Dashboard', 'Workspaces', "Setting"];

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
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          NotificationListener<UserScrollNotification>(
            //onNotification: handleScrollActivityDetected,
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
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home), label: "dashboard"),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.chart_bar), label: "history"),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.globe), label: "setting"),
                ],
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
          ),
          SafeArea(
            child: Stack(
              children: [
                //SmallFAB(
                //  icon: CupertinoIcons.search,
                //  onTap: () => Navigator.of(context)
                //      .push(CustomPageRoute.verticalTransition(SearchScreen())),
                //  bottom: isPortrait ? 220 : null,
                //  top: !isPortrait ? 0 : null,
                //  right: isPortrait ? 15 : 75,
                //  heroTag: 'Search Task',
                //),
                SmallFAB(
                  icon: CupertinoIcons.add,
                  onTap: () => Navigator.of(context).push(
                      CustomPageRoute.verticalTransition(AddEditTodoScreen())),
                  bottom: isPortrait ? 150 : null,
                  top: !isPortrait ? 0 : null,
                  right: isPortrait ? 15 : 15,
                  heroTag: 'Search Task',
                ),
              ],
            ),
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
