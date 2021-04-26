import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:noname/commons/utils/toast/show_toast.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';

class AddTodoDateWidget extends StatelessWidget {
  const AddTodoDateWidget({
    Key? key,
    required this.isNew,
    required this.editTodoProvider,
    required this.screenWidth,
  }) : super(key: key);

  final bool isNew;
  final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        EditTodoState todoState = watch(editTodoProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                  border: todoState.noStartDateError &&
                          todoState.noStartAfterEndError
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
                          child: InkWell(
                            onTap: () => onTapDatePicker(context,
                                callBack: (DateTime selectedTime) {
                              context
                                  .read(editTodoProvider.notifier)
                                  .changeStartDate(startDate: selectedTime);
                            }),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(3),
                                bottomRight: Radius.circular(3)),
                            onLongPress: () {
                              if (todoState.endDate != null) {
                                context
                                    .read(editTodoProvider.notifier)
                                    .clearEndDate();
                                ToastHelper.showToast('End Date cleared');
                              }
                            },
                            onTap: () => onTapDatePicker(context,
                                callBack: (DateTime? selectedTime) {
                              context
                                  .read(editTodoProvider.notifier)
                                  .changeEndDate(endDate: selectedTime);
                            }),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                                    todoState.endDate != null
                                        ? DateFormat("yyyy-MM-dd HH:mm")
                                            .format(todoState.endDate!)
                                        : " - ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!todoState.noStartDateError)
              Padding(
                padding: EdgeInsets.only(top: 5, left: 5),
                child: Text(EditTodoError.startDateEmptyError.str,
                    style: TextStyle(color: Colors.red[600], fontSize: 12)),
              ),
            if (!todoState.noStartAfterEndError)
              Padding(
                padding: EdgeInsets.only(top: 5, left: 5),
                child: Text(EditTodoError.stateAfterEndError.str,
                    style: TextStyle(color: Colors.red[600], fontSize: 12)),
              )
          ],
        );
      },
    );
  }

  onTapDatePicker(BuildContext context,
      {required void Function(DateTime time) callBack}) {
    DateTime? selectedTime = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: isNew ? DateTime.now() : DateTime(2000),
      lastDate: DateTime(2099),
    ).then((value) {
      if (value != null) selectedTime = value;
      showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((value) {
        if (value != null) {
          selectedTime = new DateTime(
              selectedTime!.year,
              selectedTime!.month,
              selectedTime!.day,
              value.hour,
              value.minute,
              selectedTime!.second,
              selectedTime!.millisecond,
              selectedTime!.microsecond);
          callBack(selectedTime!);
        }
      });
    });

    //showDatePickerDIalog(context);
  }
}
