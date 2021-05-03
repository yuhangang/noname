import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/providers/local/edit_todo/edit_todo_provider.dart';

import 'package:todonote/widgets/app_bar.dart';
import 'package:todonote/widgets/icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todonote/widgets/splash/splash_no_data.dart';

class HistoryScreen extends StatelessWidget {
  final bool isNew;
  final TodoTask? todoTask;
  late final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;

  HistoryScreen({TodoTask? todoTask})
      : this.isNew = todoTask == null,
        this.todoTask = todoTask {
    this.editTodoProvider =
        StateNotifierProvider.autoDispose<EditTodoProvider, EditTodoState>(
            (ref) {
      return todoTask != null
          ? EditTodoProvider(
              todoTask: todoTask,
              startDate: todoTask.startTime,
              endDate: todoTask.endTime)
          : EditTodoProvider();
    });
    if (todoTask != null) {
      titleController.text = todoTask.title;
      descriptionController.text = todoTask.description;
    }
  }
  static const String route = "/add_to_screen";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    //final node = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: "History",
        actions: [
          CustomIconButton(
              icon: Icons.menu_sharp,
              onPressed: () {
                showDialog(
                    barrierDismissible: true,
                    barrierColor:
                        Theme.of(context).primaryColorDark.withOpacity(0.2),
                    context: context,
                    builder: (context) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      return Dialog(
                        insetPadding: EdgeInsets.all(screenWidth / 20),
                        child: Container(
                            width: 500,
                            constraints:
                                BoxConstraints(maxWidth: screenWidth * 0.9),
                            child: Text(
                              "Remove All Achieved tasks",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 20),
                            )),
                      );
                    });
              })
        ],
      ),
      body: Stack(
        children: [
          Consumer(
            builder: (context, watch, child) {
              List<TodoTask> todos =
                  watch(GlobalProvider.achievedTodoProvider).tasks;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: todos.length > 0
                    ? SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                              children: todos
                                  .map((e) => RawMaterialButton(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        splashColor: Colors.black,
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {},
                                        child: InkWell(
                                          onLongPress: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColorDark
                                                    .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.4),
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(e.title,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context
                                                            .read(GlobalProvider
                                                                .achievedTodoProvider
                                                                .notifier)
                                                            .removeTodo(e);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                            Icons.done_sharp),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()),
                        ),
                      )
                    : FullScreenNoData.history.buildSplashScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
