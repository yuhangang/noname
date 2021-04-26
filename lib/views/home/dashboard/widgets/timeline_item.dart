import 'dart:developer';

import 'package:noname/commons/utils/Date/dateUtils.dart';

import 'package:flutter/material.dart';
import 'package:noname/commons/constants/models/time_line.dart';
import 'package:noname/commons/constants/theme/custom_themes/customSplashFactory.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/views/add_todo/add_todo_quick.dart';
import 'package:noname/views/add_todo/add_todo_screen.dart';
import 'package:noname/views/add_todo/widgets/edit_todo_fields.dart';
import 'package:noname/views/home/podcast_detail_screen.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';
import 'package:noname/widgets/expandable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    if (_controller.value && widget.todoList.length == 0)
      _controller.value = false;
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
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (widget.title == 'TODAY' && widget.todoList.length > 0)
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
                              "${widget.todoList.length}",
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                            )),
                          ),
                        ),
                      )
                  ],
                ),
                InkWell(
                  onTap: () {
                    showQuickCreateTodoModal(context, TimeLineTodo.today);
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.add, size: 20),
                  ),
                )
              ],
            ),
          ),
        ),
        Expandable(
          collapsed: Container(),
          theme: const ExpandableThemeData(crossFadePoint: 0.7),
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
                              onLongPress: () {
                                Navigator.of(context).push(
                                    CustomPageRoute.verticalTransition(
                                        AddEditTodoScreen(todoTask: e)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8)),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Stack(
                                  children: [
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(e.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: Colors.white)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read(GlobalProvider
                                                    .todoProvider.notifier)
                                                .removeTodo(e);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.done_sharp),
                                          ),
                                        )
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
