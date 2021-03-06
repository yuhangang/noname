import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todonote/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/providers/global/todo/src/todo_models.dart';
export 'src/todo_models.dart';
import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class AchievedTodoProvider extends StateNotifier<TodoList> {
  late final Database db;
  AchievedTodoProvider() : super(TodoList(tasks: [])) {
    this.refresh();
  }

  void refresh() => AppPreferenceProvider.fetchAchievedTodos()
      .then((value) => state = TodoList(tasks: value));

  void addTodo(TodoTask item) {
    state = TodoList.add(tasks: [...state.tasks, item]);
    AppPreferenceProvider.saveAchievedTodoList(state.tasks);
  }

  void removeAll() async {
    state = TodoList(tasks: []);
    AppPreferenceProvider.removeAchievedTodoList()
        .then((value) => TodoList(tasks: state.tasks));
  }

  void removeTodo(TodoTask todo) {
    state = state.removeItem(todo.id, state.tasks);
    Get.key!.currentState!.context
        .read(GlobalProvider.todoTagProvider.notifier)
        .removeTodo(todo.id, todo.tags);
    AppPreferenceProvider.saveAchievedTodoList(state.tasks);
  }
}
