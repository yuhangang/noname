import 'package:todonote/state/providers/global/globalProvider.dart';

const List<String> weekDay = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];

const List<String> month = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "Novement",
  "December"
];

extension DateOnlyCompare on DateTime {
  int dayDiff(DateTime other) {
    int diff = difference(other).inDays;
    return isSameDay(other)
        ? 0
        : diff == 0
            ? isAfter(other)
                ? 1
                : -1
            : diff;
  }

  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int weekDiff(DateTime other) {
    int diff = difference(other).inDays;
    return isSameDay(other)
        ? 0
        : diff == 0
            ? isAfter(other)
                ? 1
                : -1
            : diff;
  }

  List<DateTime> laterThisWeek() {
    return List<int>.generate((7 - this.weekday), (i) => i + 1)
        .map((e) => this.add(Duration(days: e)))
        .toList();
  }

  List<DateTime> nextWeek() {
    final dayTilEndOfWeek = (8 - this.weekday);
    return List<int>.generate(7, (i) => i + dayTilEndOfWeek)
        .map((e) => this.add(Duration(days: e)))
        .toList();
  }
}

class DashBoardFilteredByDate {
  List<TodoTask> today = [];
  List<TodoTask> tomorrow = [];
  List<TodoTask> nextWeek = [];
  List<TodoTask> laterThisWeek = [];
  List<TodoTask> other = [];
  DashBoardFilteredByDate(List<TodoTask> todos) {
    DateTime time = DateTime.now();
    final thisWeekDate = time.laterThisWeek();
    final nextWeekDate = time.nextWeek();

    todos.forEach((e) {
      bool isDone = false;
      if (e.startTime.dayDiff(time) == 0) {
        today.add(e);
        isDone = true;
      } else if (e.startTime.dayDiff(time) == 1) {
        tomorrow.add(e);
        isDone = true;
      }

      if (!isDone) {
        for (int i = 0; i < thisWeekDate.length; i++) {
          if (e.startTime.dayDiff(thisWeekDate[i]) == 0) {
            laterThisWeek.add(e);
            isDone = true;
            break;
          }
        }
      }
      if (!isDone) {
        for (int i = 0; i < nextWeekDate.length; i++) {
          if (e.startTime.dayDiff(nextWeekDate[i]) == 0) {
            nextWeek.add(e);
            isDone = true;
            break;
          }
        }
      }
      if (!isDone) {
        other.add(e);
      }
    });
  }
}

extension CopyWithDate on DateTime {
  DateTime copyWith(
      {int? year,
      int? month,
      int? day,
      int? hour,
      int? minute,
      int? second,
      int? millisecond,
      int? microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

extension WeekMonthName on DateTime {
  String get getWeekDay => weekDay[this.weekday - 1];
  String get getWeekDayShort => weekDay[this.weekday - 1].substring(0, 3);

  String get getMonth => month[this.month - 1];
  String get getMonthShort => month[this.month - 1].substring(0, 3);
}
