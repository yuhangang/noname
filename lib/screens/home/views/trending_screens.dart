import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:noname/commons/utils/notification/alert/alert_helper.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/screens/home/home_page.dart';
import 'package:noname/screens/home/widgets/discover_tab.dart';
import 'package:noname/screens/podcast/neumorphic_player.dart';
import 'package:noname/screens/widgets/categories_tab_bar.dart';

class TrendingScreen extends StatelessWidget {
  ScrollController listViewScrollController = new ScrollController();

  PageController pageController = PageController();
  GlobalKey<CustomTabBarState> categoryState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: HomePage.homePageAppbar(context, title: "trending"),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (_, index) {
              return Container(
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/intro_s.jpg',
                        fit: BoxFit.fitWidth,
                        width: 500,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.1),
                            ]),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Webminar",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white)),
                              Text("Google Singapore",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.grey[300]))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(CupertinoIcons.add),
                              color: Colors.white,
                              onPressed: () => Navigator.of(context).push(
                                  CustomPageRoute.verticalTransition(
                                      AudioPlayerSample())),
                            ),
                            IconButton(
                              icon: Icon(CupertinoIcons.add),
                              color: Colors.white,
                              onPressed: () =>
                                  AlertDialogHelper.showDetailDialog(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
