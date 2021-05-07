import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todonote/views/home/dashboard/dashboard_date_view.dart';
import 'package:todonote/views/home/dashboard/dashboard_task_view.dart';

import 'package:todonote/views/widgets/categories_tab_bar.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ScrollController listViewScrollController = new ScrollController();

  PageController pageController = PageController();

  GlobalKey<CustomTabBarState> categoryState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: CategoryTabBar(
            categoryState: categoryState,
            parentPageController: pageController,
            categories: ["Tasks", "Calendar"]),
        body: PageView(
          controller: pageController,
          onPageChanged: (page) {
            categoryState.currentState!.changeCategoryIndex(page);
          },
          children: [DashboardTaskView(), DashboardDateView()],
        ));
  }
}

/*
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
              return RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashColor: Colors.black,
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pushNamed(context, PodcastDetailPage.route);
                },
                child: Container(
                  height: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.4),
                                  Colors.black.withOpacity(0.2),
                                ]),
                          ),
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
                              CustomIconButton(
                                icon: CupertinoIcons.add,
                                color: Colors.white,
                                onPressed: () => Navigator.of(context).push(
                                    CustomPageRoute.verticalTransition(
                                        AudioPlayerSample())),
                              ),
                              CustomIconButton(
                                icon: CupertinoIcons.add,
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
                ),
              );
            }));
  }
}
*/
