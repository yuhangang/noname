import 'package:noname/state/providers/global/globalProvider.dart';

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
    return year == other.year && month == other.month && day == other.day;
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
    return List<int>.generate((6 - this.weekday), (i) => i + 2)
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
  DashBoardFilteredByDate(List<TodoTask> todos) {
    DateTime time = DateTime.now();
    final thisWeek = time.laterThisWeek();
    final nextWeek = time.nextWeek();
    todos.map((e) {
      if (e.startTime.dayDiff(time) == 0) {
        today.add(e);
      } else if (e.startTime.dayDiff(time) == 1) {
        tomorrow.add(e);
      }
    });
  }
  List<TodoTask> today = [];
  List<TodoTask> tomorrow = [];
  List<TodoTask> nextWeek = [];
  List<TodoTask> laterThisWeek = [];
  List<TodoTask> other = [];
}
