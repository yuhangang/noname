import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/constants/models/time_line.dart';
import 'package:noname/commons/constants/theme/custom_themes/customSplashFactory.dart';
import 'package:noname/views/add_todo/widgets/edit_todo_fields.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';
import 'package:noname/commons/utils/Date/dateUtils.dart';

void showQuickCreateTodoModal(BuildContext context, TimeLineTodo time) {
  showModalBottomSheet(
    barrierColor: const Color(0x230000000),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    builder: (context) {
      DateTime timeNow = DateTime.now();
      AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
          editTodoProvider =
          StateNotifierProvider.autoDispose<EditTodoProvider, EditTodoState>(
              (ref) {
        return EditTodoProvider(
          startDate: time.adjustedTime,
          importance: TodoImportance.medium,
        );
      });
      return QuickCreateTodo(
        time: time,
        editTodoProvider: editTodoProvider,
      );
    },
  );
}

class QuickCreateTodo extends StatefulWidget {
  QuickCreateTodo({required this.time, required this.editTodoProvider});
  TimeLineTodo time;

  final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;

  @override
  _QuickCreateTodoState createState() => _QuickCreateTodoState();
}

class _QuickCreateTodoState extends State<QuickCreateTodo> {
  TextEditingController titleController = new TextEditingController();
  DateTime? dateTime;
  late TimeOfDay dayTime;
  @override
  void initState() {
    dayTime = TimeOfDay(hour: 0, minute: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: SelectTime(
                    selected: widget.time,
                    onChange: (e) {
                      setState(() {
                        dateTime = DateTime.now();
                      });
                      context
                          .read(widget.editTodoProvider.notifier)
                          .changeStartDate(startDate: DateTime.now());
                    },
                    editTodoProvider: widget.editTodoProvider,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TodoTitleField(
                    editTodoProvider: widget.editTodoProvider,
                    titleController: titleController,
                    node: node,
                    onSavedField: (str) {
                      node.unfocus();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.time.itemAsString),
                    Text(dateTime?.toIso8601String() ?? '')
                  ],
                )
              ],
            ),
            InkWell(
              onTap: () {
                context
                    .read(widget.editTodoProvider.notifier)
                    .onSubmit(context,
                        title: titleController.text, description: '')
                    .then((value) {
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  print("error");
                  return;
                });
              },
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  ),
                )),
              ),
            ),
          ],
        ));
  }
}

class SelectTime extends StatefulWidget {
  SelectTime(
      {Key? key,
      required this.selected,
      required this.onChange,
      required this.editTodoProvider})
      : super(key: key);
  TimeLineTodo selected;
  final void Function(TimeLineTodo) onChange;
  final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;

  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minWidth: 80),
        //decoration: BoxDecoration(
        //    border: Border.all(
        //        color: Theme.of(context).primaryColorDark.withOpacity(0.5)),
        //    borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100))
                        .then((value) {
                      if (value != null) {
                        context
                            .read(widget.editTodoProvider.notifier)
                            .changeStartDate(
                                startDate: value.copyWith(hour: 0, minute: 0));
                      }
                    });
                  },
                  splashFactory: NoSplashFactory(),
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 0.5,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.4)),
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.05)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Consumer(
                      builder: (context, watch, child) {
                        DateTime startTime =
                            watch(widget.editTodoProvider).startDate ??
                                DateTime.now();
                        return Text(
                          '${startTime.getWeekDayShort}, ${startTime.day} ${startTime.getMonth} ${startTime.year.toString().substring(0, 2)}',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialEntryMode: TimePickerEntryMode.input,
                      initialTime: TimeOfDay(hour: 9, minute: 0),
                      builder: (BuildContext context, Widget? child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: false),
                          child: child ?? Container(),
                        );
                      },
                    ).then((value) {
                      if (value != null) {
                        context
                            .read(widget.editTodoProvider.notifier)
                            .changeStartDate(
                                startDate: context
                                        .read(widget.editTodoProvider)
                                        .startDate
                                        ?.copyWith(
                                            hour: value.hour,
                                            minute: value.minute) ??
                                    DateTime.now().copyWith(
                                        hour: value.hour,
                                        minute: value.minute));
                      }
                    });
                  },
                  splashFactory: NoSplashFactory(),
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 0.5,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.4)),
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.06)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15),
                    child: Consumer(
                      builder: (context, watch, child) {
                        DateTime startTime =
                            watch(widget.editTodoProvider).startDate ??
                                DateTime.now();
                        return Text(
                          '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Consumer(
                  builder: (context, watch, child) {
                    DateTime startDate =
                        watch(widget.editTodoProvider).startDate!;

                    return Tooltip(
                      message: 'Previous Day',
                      child: AbsorbPointer(
                        absorbing: startDate.isSameDay(DateTime.now()),
                        child: InkWell(
                          onTap: () {
                            DateTime date = context
                                .read(widget.editTodoProvider)
                                .startDate!;
                            date = date.add(Duration(days: -1)).copyWith(
                                hour: 9,
                                minute: 0,
                                second: 0,
                                microsecond: 0,
                                millisecond: 0);
                            context
                                .read(widget.editTodoProvider.notifier)
                                .changeStartDate(startDate: date);
                          },
                          borderRadius: BorderRadius.circular(3),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: startDate.isSameDay(DateTime.now())
                                  ? Color(0xFFADADAD)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message: 'Next Day',
                  child: InkWell(
                    onTap: () {
                      DateTime date =
                          context.read(widget.editTodoProvider).startDate!;
                      date = date.add(Duration(days: 1)).copyWith(
                          hour: 9,
                          minute: 0,
                          second: 0,
                          microsecond: 0,
                          millisecond: 0);
                      context
                          .read(widget.editTodoProvider.notifier)
                          .changeStartDate(startDate: date);
                    },
                    borderRadius: BorderRadius.circular(3),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            )
          ],
        ));
  }
}
