import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/constants/theme/custom_themes/customSplashFactory.dart';
import 'package:noname/commons/utils/toast/show_toast.dart';
import 'package:noname/screens/widgets/small_fab.dart';
import 'package:noname/state/providers/local/edit_todo_provider.dart';
import 'package:noname/state/providers/todo_provider.dart';
import 'package:noname/widgets/app_bar.dart';
import 'package:intl/intl.dart';

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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EditTodoFields(
                        titleController: titleController,
                        node: node,
                        descriptionController: descriptionController,
                        isNew: isNew,
                        editTodoProvider: editTodoProvider,
                        screenWidth: screenWidth),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                splashFactory: NoSplashFactory(),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColorDark),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)))),
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
                                      description: descriptionController.text)
                                  .then((value) {
                                Navigator.of(context).pop();
                              }).onError((error, stackTrace) {
                                ToastHelper.showToast(error.toString());
                              });

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
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            fillColor: Theme.of(context).brightness == Brightness.light
                ? Colors.black.withOpacity(0.05)
                : Colors.black.withOpacity(0.3)));
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

class EditTodoFields extends StatelessWidget {
  const EditTodoFields({
    Key? key,
    required this.titleController,
    required this.node,
    required this.descriptionController,
    required this.isNew,
    required this.editTodoProvider,
    required this.screenWidth,
  }) : super(key: key);

  final TextEditingController titleController;
  final FocusScopeNode node;
  final TextEditingController descriptionController;
  final bool isNew;
  final AutoDisposeStateNotifierProvider<EditTodoProvider> editTodoProvider;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Consumer(
            builder: (context, watch, child) {
              String? errTitle = watch(editTodoProvider.state).titleError;
              return TextFormField(
                  controller: titleController,
                  onEditingComplete: () => node.nextFocus(),
                  onChanged: (str) {
                    if (errTitle != null) {
                      context.read(editTodoProvider).clearTitleError();
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Title (Required)", errorText: errTitle));
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            scrollPadding: EdgeInsets.all(8),
            controller: descriptionController,
            decoration: InputDecoration(hintText: "Description"),
            minLines: 5,
            maxLines: null,
          ),
          SizedBox(
            height: 10,
          ),
          AddTodoDateWidget(
              isNew: isNew,
              editTodoProvider: editTodoProvider,
              screenWidth: screenWidth),
        ],
      ),
    );
  }
}

class AddTodoDateWidget extends StatelessWidget {
  const AddTodoDateWidget({
    Key? key,
    required this.isNew,
    required this.editTodoProvider,
    required this.screenWidth,
  }) : super(key: key);

  final bool isNew;
  final AutoDisposeStateNotifierProvider<EditTodoProvider> editTodoProvider;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(3),
        onTap: () {
          DateTime? selectedTime;
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: isNew ? DateTime.now() : DateTime(2000),
            lastDate: DateTime(2025),
          ).then((value) {
            selectedTime = value;
            showTimePicker(context: context, initialTime: TimeOfDay.now())
                .then((value) {
              if (selectedTime != null && value != null) {
                selectedTime = new DateTime(
                    selectedTime!.year,
                    selectedTime!.month,
                    selectedTime!.day,
                    value.hour,
                    value.minute,
                    selectedTime!.second,
                    selectedTime!.millisecond,
                    selectedTime!.microsecond);
                context
                    .read(editTodoProvider)
                    .changeStartDate(startDate: selectedTime);
              }
            });
          });

          //showDatePickerDIalog(context);
        },
        child: Consumer(
          builder: (context, watch, child) {
            EditTodoState todoState = watch(editTodoProvider.state);
            return Container(
              width: screenWidth,
              decoration: BoxDecoration(
                  border: todoState.noStartDateError
                      ? null
                      : Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(3),
                  color: Theme.of(context).primaryColorDark.withOpacity(0.04)),
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      CupertinoIcons.calendar,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              todoState.startDate != null
                                  ? DateFormat("yyyy-MM-dd HH:mm")
                                      .format(todoState.startDate!)
                                  : "required",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              todoState.startDate != null
                                  ? DateFormat("yyyy-MM-dd HH:mm")
                                      .format(todoState.startDate!)
                                  : " - ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            );
          },
        ));
  }
}
