import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/commons/constants/models/time_line.dart';
import 'package:todonote/commons/constants/theme/custom_themes/customSplashFactory.dart';
import 'package:todonote/navigation/custom_page_route/custom_page_route.dart';
import 'package:todonote/views/add_todo/add_todo_screen.dart';
import 'package:todonote/views/add_todo/widgets/edit_todo_fields.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/providers/local/edit_todo/edit_todo_provider.dart';
import 'package:todonote/commons/utils/Date/dateUtils.dart';
import 'package:todonote/views/add_todo/widgets/todo_priority_selector.dart';

void showQuickCreateTodoModal(BuildContext context, TimeLineTodo time) {
  showModalBottomSheet(
    barrierColor: const Color(0x230000000),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    builder: (context) {
      return QuickCreateTodo(
        time: time,
      );
    },
  );
}

class QuickCreateTodo extends StatefulWidget {
  QuickCreateTodo({required this.time});
  TimeLineTodo time;

  @override
  _QuickCreateTodoState createState() => _QuickCreateTodoState();
}

class _QuickCreateTodoState extends State<QuickCreateTodo> {
  TextEditingController titleController = new TextEditingController();
  late final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;
  DateTime? dateTime;
  @override
  void initState() {
    editTodoProvider =
        StateNotifierProvider.autoDispose<EditTodoProvider, EditTodoState>(
            (ref) {
      return EditTodoProvider(
        startDate: widget.time.adjustedTime,
        importance: TodoImportance.medium,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                EditTodoState editState = context.read(editTodoProvider);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    CustomPageRoute.verticalTransition(
                        AddEditTodoScreen.fromQuick(
                            todoTitle: titleController.text,
                            startTime: editState.startDate!,
                            importance: editState.importance)));
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 0.5,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.3)),
                ),
                child: Text(
                  "advanced",
                  style: TextStyle(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.6)),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: SelectTime(
                    selected: widget.time,
                    editTodoProvider: editTodoProvider,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TodoTitleField(
                    editTodoProvider: editTodoProvider,
                    titleController: titleController,
                    node: node,
                    onSavedField: (str) {
                      node.unfocus();
                    },
                  ),
                ),
                PrioritySelector(
                  provider: editTodoProvider,
                  title: 'Priority',
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context
                .read(editTodoProvider.notifier)
                .onSubmit(context, title: titleController.text, description: '')
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )),
          ),
        ),
      ],
    );
  }
}

class SelectTime extends StatefulWidget {
  SelectTime({Key? key, required this.selected, required this.editTodoProvider})
      : super(key: key);
  TimeLineTodo selected;

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
                    DateTime oldTime =
                        context.read(widget.editTodoProvider).startDate!;
                    showDatePicker(
                            context: context,
                            initialDate: oldTime,
                            firstDate: oldTime,
                            lastDate: DateTime(2100))
                        .then((value) {
                      if (value != null) {
                        context
                            .read(widget.editTodoProvider.notifier)
                            .changeStartDate(
                                startDate: value.copyWith(
                                    hour: oldTime.hour,
                                    minute: oldTime.minute));
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
                    DateTime oldTime =
                        context.read(widget.editTodoProvider).startDate!;
                    showTimePicker(
                      context: context,
                      initialEntryMode: TimePickerEntryMode.input,
                      initialTime:
                          TimeOfDay(hour: oldTime.hour, minute: oldTime.minute),
                      builder: (BuildContext context, Widget? child) {
                        return child ?? Container();
                      },
                    ).then((value) {
                      if (value != null) {
                        context
                            .read(widget.editTodoProvider.notifier)
                            .changeStartDate(
                                startDate: oldTime.copyWith(
                                    hour: value.hour, minute: value.minute));
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
                            watch(widget.editTodoProvider).startDate!;

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
                                second: 0, microsecond: 0, millisecond: 0);
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
                      date = date
                          .add(Duration(days: 1))
                          .copyWith(second: 0, microsecond: 0, millisecond: 0);
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
