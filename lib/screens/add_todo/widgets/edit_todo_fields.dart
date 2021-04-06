import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/screens/add_todo/widgets/file_uploader_button.dart';
import 'package:noname/screens/add_todo/widgets/todo_date_settings.dart';
import 'package:noname/screens/add_todo/widgets/todo_notification_setting.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';
import 'package:noname/widgets/drop_down_search/dropdown_search.dart';

class EditTodoFields extends StatelessWidget {
  const EditTodoFields({
    Key? key,
    required this.titleController,
    required this.node,
    required this.descriptionController,
    required this.isNew,
    required this.editTodoProvider,
    required this.screenWidth,
  }) : super(key: key);

  final TextEditingController titleController;
  final FocusScopeNode node;
  final TextEditingController descriptionController;
  final bool isNew;
  final AutoDisposeStateNotifierProvider<EditTodoProvider> editTodoProvider;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer(
              builder: (context, watch, child) {
                String? errTitle = watch(editTodoProvider.state).titleError;
                return TextFormField(
                    controller: titleController,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (str) {
                      if (errTitle != null) {
                        context.read(editTodoProvider).clearTitleError();
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Title (Required)", errorText: errTitle));
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              scrollPadding: EdgeInsets.all(8),
              controller: descriptionController,
              decoration: InputDecoration(hintText: "Description"),
              minLines: 5,
              maxLines: null,
            ),
            SizedBox(
              height: 10,
            ),
            AddTodoDateWidget(
                isNew: isNew,
                editTodoProvider: editTodoProvider,
                screenWidth: screenWidth),
            SizedBox(
              height: 10,
            ),
            FileUploaderButton(
                isNew: isNew,
                editTodoProvider: editTodoProvider,
                screenWidth: screenWidth),
            SizedBox(
              height: 10,
            ),
            TodoNotificationSettings(editTodoProvider: editTodoProvider),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Tags",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 16)),
                  DropdownSearch<String>(
                    validator: (v) => v == null ? "required field" : null,
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    showSearchBox: true,
                    items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                    onChanged: print,
                    popupBackgroundColor: Color(0xFF36302E),
                    popupItemDisabled: (String s) => s.startsWith('I'),
                    selectedItem: "Tunisia",
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
                      fillColor: Color(0xFF464646),
                    ),
                    onBeforeChange: (a, b) {
                      return Future.value(true);
                    },
                  ),
                ],
              ),
            ),
            Wrap(
              children: [
                ...[1, 2, 3, 4, 5, 6].map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        deleteIcon: const Icon(CupertinoIcons.xmark_circle,
                            color: Color(0xB7FFFFFF)),
                        useDeleteButtonTooltip: true,
                        onDeleted: () {},
                        label: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "A new" * e,
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                        ),
                        backgroundColor: Color(0xCB221A0F),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            )
          ],
        ),
      ),
    );
  }
}
