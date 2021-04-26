import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';

import 'package:noname/widgets/app_bar.dart';
import 'package:noname/widgets/icon_button.dart';

class WorkSpacesScreen extends StatelessWidget {
  final bool isNew;
  final TodoTask? todoTask;
  late final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;

  WorkSpacesScreen({TodoTask? todoTask})
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
      body: SafeArea(
        child: Stack(
          children: [
            Consumer(
              builder: (context, watch, child) {
                List<TodoTask> todos =
                    watch(GlobalProvider.achievedTodoProvider).tasks;
                return SingleChildScrollView(
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
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8)),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.4),
                                                    Colors.black
                                                        .withOpacity(0.2),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                          .toList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
