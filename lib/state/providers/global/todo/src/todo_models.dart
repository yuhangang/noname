import 'package:flutter/material.dart';
import 'package:noname/commons/utils/uuid/uuid_generator.dart';
import 'package:noname/state/providers/global/todo/todo_provider.dart';

class TodoList {
  TodoList({required this.tasks, this.isDone = false});
  bool isDone;
  List<TodoTask> tasks;
  TodoList.add({required this.tasks, this.isDone = true});
  factory TodoList.removeItem(String id, List<TodoTask> oldTodos) {
    try {
      oldTodos.removeAt(oldTodos.indexWhere((element) => element.id == id));
      return TodoList(tasks: oldTodos);
    } catch (e) {
      debugPrint(e.toString());
      return TodoList(tasks: [
        TodoTask(title: "-1", description: '-1', startTime: new DateTime.now())
      ]);
    }
  }

  TodoList copyWith({List<TodoTask>? tasks, bool? isDone}) {
    return TodoList(tasks: tasks ?? this.tasks, isDone: isDone ?? this.isDone);
  }

  TodoList? changeToDoTask(String id,
      {required title,
      required String description,
      required,
      required DateTime startTime,
      required DateTime? endTime}) {
    int index = this.tasks.indexWhere((element) => element.id == id);
    if (index == -1) {
      return null;
    }
    this.tasks[index].title = title;
    this.tasks[index].description = description;
    this.tasks[index].startTime = startTime;
    this.tasks[index].endTime = endTime;

    return TodoList(tasks: this.tasks);
  }
}

class TodoTask {
  final String id;
  String title;
  String description;
  final DateTime addedTime;
  DateTime startTime;
  DateTime? endTime;
  String? imgUrl;
  WorkSpace? workSpace;

  TodoTask(
      {required this.title,
      required this.description,
      required this.startTime,
      this.endTime,
      this.imgUrl})
      : this.id = UUidGenerator.getTodoId(),
        this.addedTime = DateTime.now();

  TodoTask.load(
      {required this.id,
      required this.title,
      required this.description,
      required this.startTime,
      required this.addedTime,
      this.endTime,
      this.imgUrl});

  factory TodoTask.fromJson(Map<String, dynamic> json) {
    return new TodoTask.load(
        id: json["id"],
        description: json["description"],
        title: json["title"],
        startTime: DateTime.parse(json['start_time']),
        addedTime: DateTime.parse(json['added_time']),
        endTime:
            json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
        imgUrl: json['img_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data["description"] = this.description;
    data["added_time"] = this.addedTime.toIso8601String();
    data["start_time"] = this.startTime.toIso8601String();
    data["end_time"] = this.endTime?.toIso8601String();
    data["img_url"] = this.imgUrl;

    return data;
  }
}
