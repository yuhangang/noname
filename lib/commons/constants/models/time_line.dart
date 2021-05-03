import 'package:todonote/commons/utils/Date/dateUtils.dart';

enum TimeLineTodo {
  today,
  tomorrow,
  laterThisWeek,
  nextWeek,
  nextMonth
  //nextYear
}

extension TimeLineTodoStr on TimeLineTodo {
  String get itemAsString {
    switch (this) {
      case TimeLineTodo.today:
        return "Today";
      case TimeLineTodo.tomorrow:
        return "Tomorrow";
      case TimeLineTodo.laterThisWeek:
        return "Later this Week";
      case TimeLineTodo.nextWeek:
        return "Next Week";
      case TimeLineTodo.nextMonth:
        return "Next Month";
    }
  }
}

extension TimeLineTodoAdjustTime on TimeLineTodo {
  DateTime get adjustedTime {
    DateTime dateTime = DateTime.now()
        .copyWith(minute: 0, second: 0, millisecond: 0, microsecond: 0);

    switch (this) {
      case TimeLineTodo.today:
        return dateTime.add(Duration(hours: 1));
      //
      case TimeLineTodo.tomorrow:
        dateTime = dateTime.add(Duration(hours: 1));
        dateTime = dateTime.copyWith(hour: 9).add(Duration(days: 1));
        return dateTime;
      //
      case TimeLineTodo.laterThisWeek:
        dateTime = dateTime.add(Duration(hours: 1));
        dateTime = dateTime.copyWith(hour: 9).add(Duration(days: 2));
        return dateTime;
      //
      case TimeLineTodo.nextWeek:
        dateTime = dateTime
            .add(Duration(days: 8 - dateTime.weekday))
            .copyWith(hour: 9);
        return dateTime;
      //
      case TimeLineTodo.nextMonth:
        dateTime = dateTime.copyWith(
            month: dateTime.month == 12 ? 1 : dateTime.month + 1,
            day: 1,
            hour: 9);
        return dateTime;
    }
  }
}
