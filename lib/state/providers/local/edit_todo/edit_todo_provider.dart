import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/state/providers/global/todo/todo_provider.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/providers/local/edit_todo/src/edit_todo_enums.dart';
import 'package:todonote/state/providers/local/edit_todo/src/edit_todo_models.dart';
export 'src/edit_todo_enums.dart';
export 'src/edit_todo_models.dart';

class EditTodoProvider extends StateNotifier<EditTodoState> {
  late bool isNew;
  EditTodoProvider(
      {DateTime? startDate,
      DateTime? endDate,
      TodoTask? todoTask,
      TodoImportance? importance,
      NotificationTiming? notificationTiming,
      List<TodoTag>? tags})
      : isNew = todoTask == null,
        super(new EditTodoState(
            startDate: startDate,
            endDate: endDate,
            todoTask: todoTask,
            importance: importance ?? TodoImportance.medium,
            notificationTiming: notificationTiming ?? NotificationTiming.onTime,
            tags: tags ?? [])) {
    print(state.startDate?.toIso8601String());
  }

  void changeStartDate({DateTime? startDate}) {
    bool? shouldChangeStartDate;
    if (startDate != null && state.noStartDateError == false)
      shouldChangeStartDate = true;
    state = state.copyWith(
        startDate: startDate, noStartDateError: shouldChangeStartDate);
    this._verifiedStartnEndDate();
    print(state.startDate?.toIso8601String());
  }

  void changeEndDate({required DateTime? endDate}) {
    state = state.copyWith(endDate: endDate);
    this._verifiedStartnEndDate();
  }

  Future<bool> addTag(String str) async {
    if (state.tags.where((element) => element.id == str).toList().length > 0)
      return false;
    state = state
        .copyWith(tags: [...state.tags, TodoTag(str.toLowerCase().trim())]);
    return true;
  }

  void removeTag(String str) {
    state = state.copyWith(
        tags: state.tags.where((element) => element.id != str).toList());
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

  void changeTodoImportance(TodoImportance _) =>
      state = state.copyWith(importance: _);
  void switchNotificationTiming(NotificationTiming timing) =>
      state = state.copyWith(notificationTiming: timing);

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

    if (isNew) {
      this._createTodoTask(context, title: title, description: description);
    } else {
      this._changeTodoTask(context, title: title, description: description);
    }
  }

  Future<void> _createTodoTask(BuildContext context,
      {required String title, required String description}) async {
    TodoTask newTask = new TodoTask(
        title: title,
        description: description,
        importance: state.importance,
        startTime: state.startDate ?? DateTime.now(),
        endTime: state.endDate,
        tags: state.tags,
        notificationTiming: state.notificationTiming);
    context.read(GlobalProvider.todoProvider.notifier).addTodo(newTask);
  }

  Future<void> _changeTodoTask(BuildContext context,
      {required String title, required String description}) async {
    context.read(GlobalProvider.todoProvider.notifier).changeToDoTask(
        state.todoTask!.copyWith(
            title: title,
            description: description,
            importance: state.importance,
            startTime: state.startDate ?? DateTime.now(),
            endTime: state.endDate,
            notificationTiming: state.notificationTiming));
  }
}
