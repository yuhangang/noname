import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/utils/notification/alert/alert_helper.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/screens/add_todo/add_todo_screen.dart';
import 'package:noname/screens/home/home_page.dart';
import 'package:noname/screens/home/podcast_detail_screen.dart';
import 'package:noname/screens/podcast/neumorphic_player.dart';
import 'package:noname/screens/search_screen/search_screen.dart';
import 'package:noname/screens/widgets/categories_tab_bar.dart';
import 'package:noname/state/providers/global/todo/todo_provider.dart';
import 'package:noname/state/providers/global/globalProvider.dart';

import 'package:noname/widgets/icon_button.dart';

class TrendingScreen extends StatelessWidget {
  ScrollController listViewScrollController = new ScrollController();

  PageController pageController = PageController();
  GlobalKey<CustomTabBarState> categoryState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: HomePage.homePageAppbar(context, title: "Dashboard"),
        body: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            //Padding(
            //  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            //  child: InkWell(
            //      borderRadius: BorderRadius.circular(10),
            //      onTap: () => Navigator.of(context)
            //          .push(CustomPageRoute.verticalTransition(SearchScreen())),
            //      child: AbsorbPointer(
            //          child: CupertinoSearchTextField(
            //        borderRadius: BorderRadius.circular(10),
            //        placeholder: "Search Tasks",
            //      ))),
            //),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  List<TodoTask> tasks =
                      watch(GlobalProvider.todoProvider.state).tasks;
                  return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (_, index) {
                        TodoTask task = tasks[index];
                        return RawMaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          splashColor: Colors.black,
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PodcastDetailPage.route);
                          },
                          child: InkWell(
                            onTap: () {
                              context
                                  .read(GlobalProvider.todoProvider)
                                  .removeTodo(tasks[index].id);
                            },
                            onLongPress: () {
                              print(task.id);
                              Navigator.of(context).push(
                                  CustomPageRoute.verticalTransition(
                                      AddEditTodoScreen(
                                todoTask: task,
                              )));
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(task.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        color: Colors.white)),
                                            Text(task.description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color:
                                                            Colors.grey[300]))
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomIconButton(
                                            icon: CupertinoIcons.add,
                                            color: Colors.white,
                                            onPressed: () => Navigator.of(
                                                    context)
                                                .push(CustomPageRoute
                                                    .verticalTransition(
                                                        AudioPlayerSample())),
                                          ),
                                          CustomIconButton(
                                            icon: CupertinoIcons.add,
                                            color: Colors.white,
                                            onPressed: () => AlertDialogHelper
                                                .showDetailDialog(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
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
