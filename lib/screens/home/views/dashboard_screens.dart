import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:noname/commons/constants/theme/custom_themes/customSplashFactory.dart';
import 'package:noname/commons/utils/Date/dateUtils.dart';
import 'package:noname/commons/utils/notification/alert/alert_helper.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/screens/add_todo/add_todo_screen.dart';
import 'package:noname/screens/home/home_page.dart';
import 'package:noname/screens/podcast/neumorphic_player.dart';
import 'package:noname/screens/widgets/categories_tab_bar.dart';
import 'package:noname/state/providers/global/todo/todo_provider.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/widgets/expandable.dart';
import 'package:noname/widgets/icon_button.dart';

import '../podcast_detail_screen.dart';

class DashBoardScreen extends StatelessWidget {
  ScrollController listViewScrollController = new ScrollController();

  PageController pageController = PageController();
  GlobalKey<CustomTabBarState> categoryState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: HomePage.homePageAppbar(context, title: "Dashboard"),
        body: SingleChildScrollView(
          child: Consumer(
            builder: (context, watch, _) {
              List<TodoTask> todos = watch(GlobalProvider.todoProvider).tasks;
              print(todos
                  .map((element) =>
                      element.startTime.difference(DateTime.now()).inDays)
                  .toList());
              print(DateTime(2021, 4, 18, 19, 01).dayDiff(DateTime.now()));
              print(DateTime(2021, 4, 18, 19, 01).isSameDay(DateTime.now()));
              print(DateTime(2021, 4, 16, 19, 01).laterThisWeek());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  TimeLineItem(
                      title: "TODAY",
                      todoList: todos
                          .where((element) =>
                              element.startTime.dayDiff(DateTime.now()) == 0)
                          .toList()),
                  TimeLineItem(
                    title: "TOMORROW",
                    todoList: todos
                        .where((element) =>
                            element.startTime.dayDiff(DateTime.now()) == 1)
                        .toList(),
                  ),
                  TimeLineItem(
                    title: "Later This Week",
                    todoList: todos
                        .where((element) =>
                            (element.startTime.dayDiff(DateTime.now()) != 0 &&
                                element.startTime.dayDiff(DateTime.now()) != 0))
                        .toList(),
                  ),
                  TimeLineItem(
                    title: "Next Week",
                    todoList: [],
                  ),
                  TimeLineItem(
                    title: "All",
                    todoList: [],
                  ),

                  //Expanded(
                  //  child: Consumer(
                  //    builder: (context, watch, child) {
                  //      List<TodoTask> tasks =
                  //          watch(GlobalProvider.todoProvider.state).tasks;
                  //      return ListView.builder(
                  //          itemCount: tasks.length,
                  //          itemBuilder: (_, index) {
                  //            TodoTask task = tasks[index];
                  //            return RawMaterialButton(
                  //              materialTapTargetSize:
                  //                  MaterialTapTargetSize.shrinkWrap,
                  //              splashColor: Colors.black,
                  //              padding: const EdgeInsets.all(0),
                  //              onPressed: () {
                  //                Navigator.pushNamed(
                  //                    context, PodcastDetailPage.route);
                  //              },
                  //              child: InkWell(
                  //                onTap: () {
                  //                  context
                  //                      .read(GlobalProvider.todoProvider)
                  //                      .removeTodo(tasks[index].id);
                  //                },
                  //                onLongPress: () {
                  //                  print(task.id);
                  //                  Navigator.of(context).push(
                  //                      CustomPageRoute.verticalTransition(
                  //                          AddEditTodoScreen(
                  //                    todoTask: task,
                  //                  )));
                  //                },
                  //                child: Container(
                  //                  height: 200,
                  //                  decoration: BoxDecoration(
                  //                      borderRadius: BorderRadius.circular(8)),
                  //                  margin: const EdgeInsets.symmetric(
                  //                      horizontal: 8, vertical: 8),
                  //                  child: Stack(
                  //                    children: [
                  //                      ClipRRect(
                  //                        borderRadius: BorderRadius.circular(8),
                  //                        child: Image.asset(
                  //                          'assets/images/intro_s.jpg',
                  //                          fit: BoxFit.fitWidth,
                  //                          width: 500,
                  //                        ),
                  //                      ),
                  //                      ClipRRect(
                  //                        borderRadius: BorderRadius.circular(8),
                  //                        child: Container(
                  //                          decoration: BoxDecoration(
                  //                            gradient: LinearGradient(
                  //                                begin: Alignment.topCenter,
                  //                                end: Alignment.bottomCenter,
                  //                                colors: [
                  //                                  Colors.black.withOpacity(0.4),
                  //                                  Colors.black.withOpacity(0.2),
                  //                                ]),
                  //                          ),
                  //                        ),
                  //                      ),
                  //                      Column(
                  //                        mainAxisAlignment:
                  //                            MainAxisAlignment.spaceBetween,
                  //                        crossAxisAlignment:
                  //                            CrossAxisAlignment.start,
                  //                        children: [
                  //                          Padding(
                  //                            padding: const EdgeInsets.all(10),
                  //                            child: Column(
                  //                              crossAxisAlignment:
                  //                                  CrossAxisAlignment.start,
                  //                              children: [
                  //                                Text(task.title,
                  //                                    style: Theme.of(context)
                  //                                        .textTheme
                  //                                        .headline5!
                  //                                        .copyWith(
                  //                                            color: Colors.white)),
                  //                                Text(task.description,
                  //                                    style: Theme.of(context)
                  //                                        .textTheme
                  //                                        .bodyText1!
                  //                                        .copyWith(
                  //                                            color:
                  //                                                Colors.grey[300]))
                  //                              ],
                  //                            ),
                  //                          ),
                  //                          Row(
                  //                            mainAxisAlignment:
                  //                                MainAxisAlignment.end,
                  //                            children: [
                  //                              CustomIconButton(
                  //                                icon: CupertinoIcons.add,
                  //                                color: Colors.white,
                  //                                onPressed: () => Navigator.of(
                  //                                        context)
                  //                                    .push(CustomPageRoute
                  //                                        .verticalTransition(
                  //                                            AudioPlayerSample())),
                  //                              ),
                  //                              CustomIconButton(
                  //                                icon: CupertinoIcons.add,
                  //                                color: Colors.white,
                  //                                onPressed: () => AlertDialogHelper
                  //                                    .showDetailDialog(),
                  //                              ),
                  //                            ],
                  //                          ),
                  //                        ],
                  //                      ),
                  //                    ],
                  //                  ),
                  //                ),
                  //              ),
                  //            );
                  //          });
                  //    },
                  //  ),
                  //),
                ],
              );
            },
          ),
        ));
  }
}

class TimeLineItem extends StatefulWidget {
  TimeLineItem({
    required this.title,
    Key? key,
    required this.todoList,
  }) : super(key: key);
  final String title;
  List<TodoTask> todoList;

  @override
  _TimeLineItemState createState() => _TimeLineItemState();
}

class _TimeLineItemState extends State<TimeLineItem> {
  late final ExpandableController _controller;
  @override
  void initState() {
    _controller = ExpandableController(
        initialExpanded: widget.title == 'TODAY' ? true : false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (widget.todoList.length == 0 && _controller.value == false)
              return;

            setState(() {
              _controller.toggle();
            });
          },
          splashColor: Colors.transparent,
          splashFactory: NoSplashFactory(),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      this.widget.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (widget.title == 'TODAY')
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: _controller.value ? 0 : 1.0,
                        child: ClipOval(
                          child: Container(
                            width: 18,
                            height: 18,
                            color: Colors.red,
                            child: Center(
                                child: Text(
                              "1",
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                            )),
                          ),
                        ),
                      )
                  ],
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      barrierColor: const Color(0x230000000),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      context: context,
                      builder: (context) {
                        return Container(
                            padding: EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                Wrap(
                                  children: [
                                    ...([
                                      'Today',
                                      'Tomorrow',
                                    ] as List<String>)
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 3),
                                              child: InkWell(
                                                onTap: () {
                                                  print(e);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  constraints: BoxConstraints(
                                                      minWidth: 80),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorDark
                                                              .withOpacity(
                                                                  0.5)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Text(
                                                    'Today',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ],
                                ),
                                Text("text"),
                              ],
                            ));
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
        ),
        Expandable(
          collapsed: Container(),
          theme: const ExpandableThemeData(crossFadePoint: 0),
          expanded: Container(
              child: Center(
            child: widget.todoList.length != 0
                ? Column(
                    children: [
                      ...widget.todoList.map((e) => RawMaterialButton(
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
                                    .read(GlobalProvider.todoProvider.notifier)
                                    .removeTodo(e.id);
                              },
                              onLongPress: () {
                                print(e.id);
                                Navigator.of(context).push(
                                    CustomPageRoute.verticalTransition(
                                        AddEditTodoScreen(todoTask: e)));
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
                                              Text(e.title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          color: Colors.white)),
                                              Text(e.description,
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
                          ))
                    ],
                  )
                : Text('Nothing'),
          )),
          controller: _controller,
        ),
      ],
    );
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
