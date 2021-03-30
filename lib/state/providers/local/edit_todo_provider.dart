import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/state/providers/globalProvider.dart';
import 'package:noname/state/providers/todo_provider.dart';

enum EditTodoError { titleEmptyError, startDateEmptyError }

extension ParseToString on EditTodoError {
  String get str {
    switch (this) {
      case EditTodoError.titleEmptyError:
        return "title is empty";
      case EditTodoError.startDateEmptyError:
        return "start date unselected";
    }
  }
}

class EditTodoProvider extends StateNotifier<EditTodoState> {
  EditTodoProvider({DateTime? startDate, DateTime? endDate, TodoTask? todoTask})
      : super(new EditTodoState(
            startDate: startDate, endDate: endDate, todoTask: todoTask));
  void changeStartDate({DateTime? startDate, DateTime? endDate}) {
    bool? shouldChangeStartDate;
    if (startDate != null && state.noStartDateError == false)
      shouldChangeStartDate = true;
    state = state.copyWith(
        startDate: startDate,
        endDate: endDate,
        noStartDateError: shouldChangeStartDate);
  }

  void clearTitleError() => state = state.copyWith(noTitleError: true);
  void clearStartDateError() => state = state.copyWith(noStartDateError: true);

  Future<void> onSubmit(BuildContext context,
      {required String title, required String description}) async {
    bool validTitle = title.length > 0;
    bool validStartDate = state.startDate != null;

    if (!validTitle || !validStartDate) {
      state = state.copyWith(
          noTitleError: validTitle, noStartDateError: validStartDate);
      if (!validTitle) throw EditTodoError.titleEmptyError.str;
      if (!validStartDate) throw EditTodoError.startDateEmptyError.str;
    }

    if (state.todoTask == null) {
      print("create");
      _createTodoTask(context, title: title, description: description);
    } else {
      print("add");
      _changeTodoTask(context,
          title: title, description: description, todoId: state.todoTask!.id);
    }
  }

  Future<void> _createTodoTask(BuildContext context,
      {required String title, required String description}) async {
    context.read(GlobalProvider.todoProvider).addTodo(new TodoTask(
        title: title,
        description: description,
        startTime: state.startDate ?? DateTime.now(),
        endTime: state.endDate));
  }

  Future<void> _changeTodoTask(BuildContext context,
      {required String title,
      required String description,
      required String todoId}) async {
    context.read(GlobalProvider.todoProvider).changeToDoTask(todoId,
        title: title,
        description: description,
        startTime: state.startDate ?? DateTime.now(),
        endTime: state.endDate);
  }
}

class EditTodoState {
  EditTodoState(
      {this.startDate,
      this.endDate,
      this.titleError,
      this.noStartDateError = true,
      this.todoTask});
  DateTime? startDate;
  DateTime? endDate;
  String? titleError;
  bool noStartDateError;
  final TodoTask? todoTask;

  EditTodoState copyWith(
      {DateTime? startDate,
      DateTime? endDate,
      bool? noTitleError,
      bool? noStartDateError}) {
    return new EditTodoState(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        titleError: noTitleError != null
            ? noTitleError
                ? null
                : EditTodoError.titleEmptyError.str
            : this.titleError,
        noStartDateError: noStartDateError ?? this.noStartDateError);
  }
}
