import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/commons/utils/settings/shared_preferences/app_preference_provider.dart';
import 'package:todonote/state/providers/global/todo/src/todo_models.dart';
export 'src/todo_models.dart';

class TodoTagProvider extends StateNotifier<TodoTagList> {
  TodoTagProvider() : super(TodoTagList(tags: [])) {
    AppPreferenceProvider.fetchTodoTags()
        .then((value) => state = TodoTagList(tags: value));
  }
  void addTodo(String taskId, List<TodoTag> tags) {
    tags.forEach((e) {
      int index = state.tags.indexWhere((element) => element.id == e.id);
      if (index == -1) {
        state = state.copyWith(tags: [
          ...state.tags,
          new TodoTag(e.id, linkedTask: [taskId])
        ]);
      } else {
        if (state.tags[index].linkedTask
                .indexWhere((element) => element == taskId) ==
            -1) {
          state.tags[index].linkedTask.add(taskId);
          state = state.copyWith();
        }
      }
    });
    AppPreferenceProvider.saveTodoTagList(state.tags);
  }

  void removeTodo(String taskId, List<TodoTag> oldTags) {
    state = state.removeItem(taskId, oldTags);
    AppPreferenceProvider.saveTodoTagList(state.tags);
  }
}

class TodoTagList {
  TodoTagList({required this.tags, this.isDone = false});
  bool isDone;
  List<TodoTag> tags;
//TodoTagList.add({required this.tags, this.isDone = true});
  TodoTagList removeItem(String id, List<TodoTag> oldTags) {
    try {
      oldTags.forEach((element) {
        tags.where((e) => e.id == element.id).map((e) {
          e.linkedTask.removeWhere((element) => element == id);
        });
        tags.removeAt(tags.indexWhere(
            (element) => element.id == id && element.linkedTask.length == 0));
        debugPrint("Remove todo tag");
      });

      return TodoTagList(tags: tags);
    } catch (e) {
      return TodoTagList(tags: []);
    }
  }

  TodoTagList copyWith({List<TodoTag>? tags, bool? isDone}) {
    return TodoTagList(tags: tags ?? this.tags, isDone: isDone ?? this.isDone);
  }
}
