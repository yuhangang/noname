import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:noname/commons/utils/notification/push_notification/push_notification.dart';
import 'package:noname/commons/utils/notification/push_notification/src/notification_show/notification_helper.dart';
import 'package:noname/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:noname/commons/utils/uuid/uuid_generator.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/global/todo/src/todo_models.dart';
export 'src/todo_models.dart';
import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class TodoProvider extends StateNotifier<TodoList> {
  late final Database db;
  TodoProvider() : super(TodoList(tasks: [])) {
    AppPreferenceProvider.fetchTodos()
        .then((value) => state = TodoList(tasks: value));
  }
  void addTodo(TodoTask item) {
    state = TodoList.add(tasks: [...state.tasks, item]);
    Get.key!.currentState!.context
        .read(GlobalProvider.todoTagProvider.notifier)
        .addTodo(item.id, item.tags);
    AppPreferenceProvider.saveTodoList(state.tasks);
    LocalNotificationHelper.showScheduledNotification(NotificationIdSet(
        todoId: item.id,
        startTime: item.startTime,
        notificationTiming: item.notificationTiming,
        endTime: item.endTime));
  }

  void removeTodo(TodoTask item) {
    state = state.removeItem(item.id, state.tasks);
    Get.key!.currentState!.context
        .read(GlobalProvider.todoTagProvider.notifier)
        .removeTodo(item.id, item.tags);

    AppPreferenceProvider.saveTodoList(state.tasks);
    //AppPreferenceProvider.saveAchievedTodoList(todo);
    //
    LocalNotificationHelper.removeScheduledNotification(NotificationIdSet(
        todoId: item.id,
        startTime: item.startTime,
        notificationTiming: item.notificationTiming,
        endTime: item.endTime));
  }

  void setTodo() {
    state = state.copyWith(isDone: !state.isDone);
  }

  Future<void> changeToDoTask(TodoTask item) async {
    TodoList? newTodoList = state.changeToDoTask(item);
    if (newTodoList == null) throw "error";
    AppPreferenceProvider.saveTodoList(state.tasks);
    state = newTodoList;
    LocalNotificationHelper.showScheduledNotification(NotificationIdSet(
        todoId: item.id,
        startTime: item.startTime,
        notificationTiming: item.notificationTiming,
        endTime: item.endTime));
  }
}
