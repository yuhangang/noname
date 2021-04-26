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
