enum NotificationTiming { onTime, tenMin, oneHour, oneDay, oneWeek }

extension NotificationTimingStr on NotificationTiming {
  String get itemAsString {
    switch (this) {
      case NotificationTiming.onTime:
        return "on Time";
      case NotificationTiming.tenMin:
        return "10 mins";
      case NotificationTiming.oneHour:
        return "1 hour";
      case NotificationTiming.oneDay:
        return "1 hours";
      case NotificationTiming.oneDay:
        return "1 day";
      case NotificationTiming.oneWeek:
        return "1 week";
    }
  }
}

enum EditTodoError { titleEmptyError, startDateEmptyError, stateAfterEndError }

extension ParseToString on EditTodoError {
  String get str {
    switch (this) {
      case EditTodoError.titleEmptyError:
        return "title is empty";
      case EditTodoError.startDateEmptyError:
        return "start date unselected";
      case EditTodoError.stateAfterEndError:
        return "start date must not after end date";
    }
  }
}
