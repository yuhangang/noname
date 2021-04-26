import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/constants/models/time_line.dart';
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
          startDate: timeNow.copyWith(day: timeNow.day + 1),
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
                      context
                          .read(widget.editTodoProvider.notifier)
                          .changeStartDate(startDate: DateTime.now());
                    },
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
            )
          ],
        ));
  }
}

class SelectTime extends StatefulWidget {
  SelectTime({Key? key, required this.selected, required this.onChange})
      : super(key: key);
  TimeLineTodo selected;
  final void Function(TimeLineTodo) onChange;
  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ...(TimeLineTodo.values.map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.selected = e;
                    widget.onChange(e);
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(minWidth: 80),
                  decoration: BoxDecoration(
                      color: widget.selected == e
                          ? Theme.of(context).primaryColorDark.withOpacity(0.7)
                          : null,
                      border: Border.all(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    e.itemAsString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.selected == e
                            ? Theme.of(context).primaryColor
                            : null),
                  ),
                ),
              ),
            ))),
      ],
    );
  }
}
