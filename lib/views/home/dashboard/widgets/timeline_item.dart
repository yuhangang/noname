import 'dart:developer';

import 'package:todonote/commons/utils/Date/dateUtils.dart';

import 'package:flutter/material.dart';
import 'package:todonote/commons/constants/models/time_line.dart';
import 'package:todonote/commons/constants/theme/custom_themes/customSplashFactory.dart';
import 'package:todonote/navigation/custom_page_route/custom_page_route.dart';
import 'package:todonote/views/add_todo/add_todo_quick.dart';
import 'package:todonote/views/add_todo/add_todo_screen.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/views/home/dashboard/widgets/todo_task_tile.dart';
import 'package:todonote/widgets/expandable.dart';

class TimeLineItem extends StatefulWidget {
  TimeLineItem(
      {required this.title,
      Key? key,
      required this.todoList,
      required this.timeLineTodo})
      : super(key: key);
  final String title;
  final TimeLineTodo timeLineTodo;
  final List<TodoTask> todoList;

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
          child: buildTimeItem(context),
        ),
        Expandable(
          collapsed: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(),
          ),
          theme: const ExpandableThemeData(crossFadePoint: 0.7),
          expanded: Container(
              child: Center(
            child: widget.todoList.length != 0
                ? Column(
                    children: [
                      ...widget.todoList
                          .map((e) => TodoTaskTile(context: context, e: e))
                    ],
                  )
                : Text('Nothing'),
          )),
          controller: _controller,
        ),
      ],
    );
  }

  Padding buildTimeItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                this.widget.title,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColorDark.withOpacity(0.8)),
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
              showQuickCreateTodoModal(context, widget.timeLineTodo);
            },
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.add,
                size: 20,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            ),
          )
        ],
      ),
    );
  }
}
