import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/edit_todo/src/edit_todo_enums.dart';

class EditTodoState {
  EditTodoState(
      {this.startDate,
      this.endDate,
      this.titleError,
      this.noStartDateError = true,
      this.noStartAfterEndError = true,
      this.showNotification = false,
      this.todoTask,
      this.notificationTiming = NotificationTiming.onTime});
  DateTime? startDate;
  DateTime? endDate;
  String? titleError;
  bool noStartDateError;
  bool noStartAfterEndError;
  final TodoTask? todoTask;
  bool showNotification;

  NotificationTiming notificationTiming;

  EditTodoState copyWith(
      {DateTime? startDate,
      DateTime? endDate,
      bool? noTitleError,
      bool? noStartDateError,
      bool? noStartAfterEndError,
      bool? showNotification,
      bool removeEndDate = false,
      NotificationTiming? notificationTiming}) {
    return new EditTodoState(
        startDate: startDate ?? this.startDate,
        endDate: removeEndDate ? null : endDate ?? this.endDate,
        titleError: noTitleError != null
            ? noTitleError
                ? null
                : EditTodoError.titleEmptyError.str
            : this.titleError,
        showNotification: showNotification ?? this.showNotification,
        noStartDateError: noStartDateError ?? this.noStartDateError,
        noStartAfterEndError: noStartAfterEndError ?? this.noStartAfterEndError,
        notificationTiming: notificationTiming ?? this.notificationTiming);
  }
}
