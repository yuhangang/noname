import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/views/add_todo/widgets/todo_priority_selector.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';
import 'package:noname/widgets/drop_down_search/dropdown_search.dart';
import 'package:noname/widgets/expanded_session.dart';
import 'package:noname/widgets/setting/switch_button_item.dart';

class TodoNotificationSettings extends StatelessWidget {
  const TodoNotificationSettings({
    Key? key,
    required this.editTodoProvider,
  }) : super(key: key);

  final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, child) {
        EditTodoState editTodoState = watch(editTodoProvider);

        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            PrioritySelector(
              title: 'Priority',
              provider: editTodoProvider,
              selectedItem: editTodoState.importance,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(3),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Notification",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 16)),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownSearch<NotificationTiming>(
                      mode: Mode.MENU,
                      items: NotificationTiming.values,
                      itemAsString: (_) => _.itemAsString,
                      compareFn: (a, b) {
                        return a.itemAsString ==
                            (b != null ? b.itemAsString : "");
                      },
                      onChanged: (newValue) {
                        if (newValue != null)
                          context
                              .read(editTodoProvider.notifier)
                              .switchNotificationTiming(newValue);
                      },
                      popupBackgroundColor: Color(0xFF36302E),
                      selectedItem: editTodoState.notificationTiming,
                      showSelectedItem: true,
                      dropDownItemTextStyle:
                          TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
                      dropdownButtonBuilder: (context) {
                        return Icon(CupertinoIcons.arrow_down_circle);
                      },
                      searchBoxStyle: TextStyle(color: Color(0xFFF0F0F0)),
                      dropdownSearchDecoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(),
                          fillColor: Colors.transparent),
                      searchBoxDecoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "search keywords",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Color(0xFF615D59),
                      ),
                      onBeforeChange: (a, b) {
                        return Future.value(true);
                      },
                    ),
                    //DropdownButton<NotificationTiming>(
                    //  value: editTodoState.notificationTiming,
                    //  icon: const Icon(Icons.arrow_circle_down),
                    //  iconSize: 24,
                    //  elevation: 10,
                    //  isExpanded: true,
                    //  menuMaxHeight: 300,
                    //  isDense: true,
                    //  selectedItemBuilder: (BuildContext context) {
                    //    return NotificationTiming.values.map((value) {
                    //      return Container(
                    //        child: Text(
                    //          value.itemAsString,
                    //          style: TextStyle(
                    //              color: Theme.of(context).primaryColorDark),
                    //        ),
                    //      );
                    //    }).toList();
                    //  },
                    //  style: TextStyle(
                    //      color: Theme.of(context).primaryColorDark),
                    //  dropdownColor:
                    //      Theme.of(context).brightness == Brightness.dark
                    //          ? Color(0xFF222222)
                    //          : Color(0xFF413A35),
                    //  underline: Container(
                    //    height: 1,
                    //    color: Theme.of(context).primaryColorDark,
                    //  ),
                    //  onChanged: (newValue) {
                    //    if (newValue != null)
                    //      context
                    //          .read(editTodoProvider)
                    //          .switchNotificationTiming(newValue);
                    //  },
                    //  items: NotificationTiming.values
                    //      .map<DropdownMenuItem<NotificationTiming>>((value) {
                    //    return DropdownMenuItem<NotificationTiming>(
                    //        value: value,
                    //        child: Container(
                    //            child: Text(value.itemAsString,
                    //                style: TextStyle(
                    //                  color: Colors.white,
                    //                ))));
                    //  }).toList(),
                    //),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
      },
    );
  }
}
