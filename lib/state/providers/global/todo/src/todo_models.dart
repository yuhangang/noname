import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonote/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:todonote/commons/utils/uuid/uuid_generator.dart';

class TodoList {
  TodoList({required this.tasks, this.isDone = false});
  bool isDone;
  List<TodoTask> tasks;
  TodoList.add({required this.tasks, this.isDone = true});
  TodoList removeItem(String id, List<TodoTask> oldTodos) {
    try {
      oldTodos.removeAt(oldTodos.indexWhere((element) => element.id == id));
      return TodoList(tasks: oldTodos);
    } catch (e) {
      debugPrint(e.toString());
      return TodoList(tasks: []);
    }
  }

  TodoList copyWith({List<TodoTask>? tasks, bool? isDone}) {
    return TodoList(tasks: tasks ?? this.tasks, isDone: isDone ?? this.isDone);
  }

  TodoList? changeToDoTask(TodoTask task) {
    int index = this.tasks.indexWhere((element) => element.id == task.id);
    print("fdrefrtr");
    if (index == -1) {
      return null;
    }
    this.tasks[index] = task;

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
  TodoImportance importance;
  NotificationTiming notificationTiming;
  List<TodoTag> tags;

  TodoTask(
      {required this.title,
      required this.description,
      required this.startTime,
      required this.importance,
      required this.notificationTiming,
      required this.tags,
      this.endTime,
      this.imgUrl})
      : this.id = UUidGenerator.getTodoId(),
        this.addedTime = DateTime.now();

  TodoTask copyWith(
      {String? title,
      String? description,
      DateTime? startTime,
      TodoImportance? importance,
      DateTime? endTime,
      NotificationTiming? notificationTiming,
      List<TodoTag>? tags,
      String? imgUrl}) {
    return TodoTask.load(
        id: this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        addedTime: this.addedTime,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        notificationTiming: notificationTiming ?? this.notificationTiming,
        imgUrl: imgUrl ?? this.imgUrl,
        tags: tags ?? this.tags,
        importance: importance ?? this.importance);
  }

  TodoTask.load(
      {required this.id,
      required this.title,
      required this.description,
      required this.startTime,
      required this.addedTime,
      required this.importance,
      required this.notificationTiming,
      required this.tags,
      this.endTime,
      this.imgUrl});

  factory TodoTask.fromJson(Map<String, dynamic> json) {
    List<TodoTag> tags = [];

    json['tags'].forEach((e) => tags.add(TodoTag.fromJson(e)));
    return new TodoTask.load(
        id: json["id"],
        description: json["description"],
        title: json["title"],
        startTime: DateTime.parse(json['start_time']),
        addedTime: DateTime.parse(json['added_time']),
        importance: TodoImportance.values.firstWhere(
            (element) => json['importance'] == element.itemAsString),
        notificationTiming: NotificationTiming.values.firstWhere(
            (element) => json['notification_timing'] == element.itemAsString),
        tags: tags,
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
    data["importance"] = this.importance.itemAsString;
    data['notification_timing'] = this.notificationTiming.itemAsString;
    data['tags'] = this.tags.map((e) => e.toJson()).toList();

    return data;
  }
}

enum TodoImportance { low, medium, high }

extension TodoImportanceTimingStr on TodoImportance {
  String get itemAsString {
    switch (this) {
      case TodoImportance.low:
        return "low";
      case TodoImportance.medium:
        return "medium";
      case TodoImportance.high:
        return "high";
    }
  }
}

enum NotificationTiming { none, onTime, tenMin, oneHour, oneDay, oneWeek }

extension NotificationTimingStr on NotificationTiming {
  String get itemAsString {
    switch (this) {
      case NotificationTiming.none:
        return 'none';
      case NotificationTiming.onTime:
        return "on Time";
      case NotificationTiming.tenMin:
        return "10 mins";
      case NotificationTiming.oneHour:
        return "1 hour";
      case NotificationTiming.oneDay:
        return "1 day";
      case NotificationTiming.oneWeek:
        return "1 week";
    }
  }

  DateTime adjustedTime(DateTime time) {
    switch (this) {
      case NotificationTiming.none:
        return time;
      case NotificationTiming.onTime:
        return time;
      case NotificationTiming.tenMin:
        return time.add(Duration(minutes: -10));
      case NotificationTiming.oneHour:
        return time.add(Duration(hours: 1));
      case NotificationTiming.oneDay:
        return time.add(Duration(days: 1));
      case NotificationTiming.oneWeek:
        return time.add(Duration(days: 7));
    }
  }
}

class TodoTag {
  final String id;
  List<String> linkedTask;
  TodoTag(this.id, {this.linkedTask = const []});

  factory TodoTag.fromJson(dynamic json) {
    List<String> tasks = [];
    json['linked_task'].forEach((e) => tasks.add(e));
    return TodoTag(json['id'], linkedTask: tasks);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['linked_task'] = this.linkedTask;
    return data;
  }
}
