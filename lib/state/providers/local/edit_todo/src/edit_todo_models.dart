import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/providers/local/edit_todo/src/edit_todo_enums.dart';

class EditTodoState {
  EditTodoState(
      {this.startDate,
      this.endDate,
      this.titleError,
      this.noStartDateError = true,
      this.noStartAfterEndError = true,
      this.importance = TodoImportance.medium,
      this.todoTask,
      this.notificationTiming = NotificationTiming.onTime,
      this.tags = const []});
  DateTime? startDate;
  DateTime? endDate;
  String? titleError;
  bool noStartDateError;
  bool noStartAfterEndError;
  final TodoTask? todoTask;
  List<TodoTag> tags;

  TodoImportance importance;

  NotificationTiming notificationTiming;

  EditTodoState copyWith(
      {DateTime? startDate,
      DateTime? endDate,
      bool? noTitleError,
      bool? noStartDateError,
      bool? noStartAfterEndError,
      TodoImportance? importance,
      bool removeEndDate = false,
      List<TodoTag>? tags,
      NotificationTiming? notificationTiming}) {
    return new EditTodoState(
        startDate: startDate ?? this.startDate,
        endDate: removeEndDate ? null : endDate ?? this.endDate,
        titleError: noTitleError != null
            ? noTitleError
                ? null
                : EditTodoError.titleEmptyError.str
            : this.titleError,
        noStartDateError: noStartDateError ?? this.noStartDateError,
        importance: importance ?? this.importance,
        todoTask: this.todoTask,
        tags: tags ?? this.tags,
        noStartAfterEndError: noStartAfterEndError ?? this.noStartAfterEndError,
        notificationTiming: notificationTiming ?? this.notificationTiming);
  }
}
