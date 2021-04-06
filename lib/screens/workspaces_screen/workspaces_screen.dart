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
  late final AutoDisposeStateNotifierProvider<EditTodoProvider>
      editTodoProvider;

  WorkSpacesScreen({TodoTask? todoTask})
      : this.isNew = todoTask == null,
        this.todoTask = todoTask {
    this.editTodoProvider = StateNotifierProvider.autoDispose((ref) {
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
        title: "Workspaces",
        actions: [
          CustomIconButton(
              icon: CupertinoIcons.add_circled,
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
                              "Add new workspace",
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
          children: [],
        ),
      ),
    );
  }
}
