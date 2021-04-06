import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/constants/theme/custom_themes/customSplashFactory.dart';
import 'package:noname/commons/utils/toast/show_toast.dart';
import 'package:noname/screens/add_todo/widgets/edit_todo_fields.dart';
import 'package:noname/screens/widgets/small_fab.dart';
import 'package:noname/state/providers/global/globalProvider.dart';

import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';

import 'package:noname/widgets/app_bar.dart';

class AddEditTodoScreen extends StatelessWidget {
  final bool isNew;
  final TodoTask? todoTask;
  late final AutoDisposeStateNotifierProvider<EditTodoProvider>
      editTodoProvider;

  AddEditTodoScreen({TodoTask? todoTask})
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
    final screenWidth = MediaQuery.of(context).size.width;
    final node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: () async {
        this.showToastOnDiscard();
        return true;
      },
      child: Theme(
        data: addTodoTheme(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: this.isNew ? "New Task" : "Edit Task",
            onBackCalledBack: this.showToastOnDiscard,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Stack(
                  children: [
                    EditTodoFields(
                        titleController: titleController,
                        node: node,
                        descriptionController: descriptionController,
                        isNew: isNew,
                        editTodoProvider: editTodoProvider,
                        screenWidth: screenWidth),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  stops: [
                                0,
                                0.3,
                                1
                              ],
                                  colors: [
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.0),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.95),
                                Theme.of(context).scaffoldBackgroundColor
                              ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    splashFactory: NoSplashFactory(),
                                    side: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)))),
                                child: Center(
                                    child: Text(
                                  "SAVE",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )),
                                onPressed: () {
                                  context
                                      .read(editTodoProvider)
                                      .onSubmit(context,
                                          title: titleController.text,
                                          description:
                                              descriptionController.text)
                                      .then((value) {
                                    Navigator.of(context).pop();
                                  }).onError((error, stackTrace) {});

                                  //context.read(GlobalProvider.todoProvider).addTodo(
                                  //    TodoTask(
                                  //        title: "new title",
                                  //        description: '',
                                  //        startTime: DateTime.now()));
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplashFactory(),
                                ),
                                child: Text(
                                  "DISCARD",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SmallFAB(
                    icon: Icons.menu_open,
                    onTap: () {},
                    positionB: 200,
                    positionR: 15,
                    heroTag: 'Options')
              ],
            ),
          ),
        ),
      ),
    );
  }

  ThemeData addTodoTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
            focusColor: Colors.black,
            filled: true,
            errorBorder: new OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF0000)),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                )),
            focusedBorder: new OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC7C7C7), width: 2),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            border: new OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(color: Color(0xFFC7C7C7), width: 2),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            fillColor: Colors.transparent));
  }

  Future<dynamic> showDatePickerDIalog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "2012",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "To",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "2013",
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    currentDate: null,
                    initialCalendarMode: DatePickerMode.day,
                    onDateChanged: (DateTime time) {
                      context
                          .read(editTodoProvider)
                          .changeStartDate(startDate: time);
                    }),
              ],
            ),
          );
        });
  }

  void showToastOnDiscard() {
    if (isNew) ToastHelper.showToast("Saved changes as draft");
  }
}
