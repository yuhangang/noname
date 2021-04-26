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
