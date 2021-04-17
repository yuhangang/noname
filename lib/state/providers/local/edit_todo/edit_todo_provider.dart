import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/state/providers/global/todo/todo_provider.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/edit_todo/src/edit_todo_enums.dart';
import 'package:noname/state/providers/local/edit_todo/src/edit_todo_models.dart';
export 'src/edit_todo_enums.dart';
export 'src/edit_todo_models.dart';

class EditTodoProvider extends StateNotifier<EditTodoState> {
  EditTodoProvider({DateTime? startDate, DateTime? endDate, TodoTask? todoTask})
      : super(new EditTodoState(
            startDate: startDate, endDate: endDate, todoTask: todoTask));
  void changeStartDate({DateTime? startDate}) {
    bool? shouldChangeStartDate;
    if (startDate != null && state.noStartDateError == false)
      shouldChangeStartDate = true;
    state = state.copyWith(
        startDate: startDate, noStartDateError: shouldChangeStartDate);
    print(this._verifiedStartnEndDate());
  }

  void changeEndDate({required DateTime? endDate}) {
    state = state.copyWith(endDate: endDate);
    print(this._verifiedStartnEndDate());
  }

  bool _verifiedStartnEndDate() {
    if (state.startDate != null && state.endDate != null) {
      if (state.startDate!.isAfter(state.endDate!)) {
        if (state.noStartAfterEndError) {
          state = state.copyWith(noStartAfterEndError: false);
        }

        return false;
      } else if (!state.noStartAfterEndError) {
        state = state.copyWith(noStartAfterEndError: true);
      }
    }
    return true;
  }

  void switchNotificationTiming(NotificationTiming timing) =>
      state = state.copyWith(notificationTiming: timing);
  void switchNotificationMode() =>
      state = state.copyWith(showNotification: !state.showNotification);
  void clearEndDate() => state = state.copyWith(removeEndDate: true);
  void clearTitleError() => state = state.copyWith(noTitleError: true);
  void clearStartDateError() => state = state.copyWith(noStartDateError: true);

  Future<void> onSubmit(BuildContext context,
      {required String title, required String description}) async {
    bool validTitle = title.length > 0;
    bool validStartDate = state.startDate != null;
    bool startBeforeEnd = this._verifiedStartnEndDate();

    if (!validTitle || !validStartDate || !startBeforeEnd) {
      state = state.copyWith(
          noTitleError: validTitle, noStartDateError: validStartDate);
      if (!validTitle) throw EditTodoError.titleEmptyError.str;
      if (!validStartDate) throw EditTodoError.startDateEmptyError.str;
      if (!startBeforeEnd) throw EditTodoError.stateAfterEndError;
    }

    if (state.todoTask == null) {
      this._createTodoTask(context, title: title, description: description);
    } else {
      this._changeTodoTask(context,
          title: title, description: description, todoId: state.todoTask!.id);
    }
  }

  Future<void> _createTodoTask(BuildContext context,
      {required String title, required String description}) async {
    context.read(GlobalProvider.todoProvider.notifier).addTodo(new TodoTask(
        title: title,
        description: description,
        startTime: state.startDate ?? DateTime.now(),
        endTime: state.endDate));
  }

  Future<void> _changeTodoTask(BuildContext context,
      {required String title,
      required String description,
      required String todoId}) async {
    context.read(GlobalProvider.todoProvider.notifier).changeToDoTask(todoId,
        title: title,
        description: description,
        startTime: state.startDate ?? DateTime.now(),
        endTime: state.endDate);
  }
}
