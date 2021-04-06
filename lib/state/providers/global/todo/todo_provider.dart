import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:noname/commons/utils/uuid/uuid_generator.dart';
import 'package:noname/state/providers/global/todo/src/todo_models.dart';
export 'src/todo_models.dart';

class WorkSpace {
  final String id;
  final String title;
  final Color color;
  WorkSpace({required this.title, required this.color})
      : this.id = UUidGenerator.getWorkspaceId();
}

class TodoProvider extends StateNotifier<TodoList> {
  TodoProvider() : super(TodoList(tasks: [])) {
    AppPreferenceProvider.fetchTodos()
        .then((value) => state = TodoList(tasks: value));
  }
  void addTodo(TodoTask item) {
    state = TodoList.add(tasks: [...state.tasks, item]);
    AppPreferenceProvider.saveTodoList(state.tasks);
  }

  void removeTodo(String id) {
    state = TodoList.removeItem(id, state.tasks);
    AppPreferenceProvider.saveTodoList(state.tasks);
  }

  void setTodo() {
    state = state.copyWith(isDone: !state.isDone);
  }

  Future<void> changeToDoTask(String id,
      {required title,
      required String description,
      required DateTime startTime,
      required DateTime? endTime}) async {
    TodoList? newTodoList = await state.changeToDoTask(id,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime);
    if (newTodoList == null) throw "error";

    state = newTodoList;
  }
}
