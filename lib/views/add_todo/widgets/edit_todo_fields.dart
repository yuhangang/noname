import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/commons/utils/toast/show_toast.dart';
import 'package:todonote/views/add_todo/widgets/file_uploader_button.dart';
import 'package:todonote/views/add_todo/widgets/todo_date_settings.dart';
import 'package:todonote/views/add_todo/widgets/todo_notification_setting.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/providers/local/edit_todo/edit_todo_provider.dart';
import 'package:todonote/widgets/drop_down_search/dropdown_search.dart';

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
  final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TodoTitleField(
                editTodoProvider: editTodoProvider,
                titleController: titleController,
                node: node),
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
            //FileUploaderButton(
            //    isNew: isNew,
            //    editTodoProvider: editTodoProvider,
            //    screenWidth: screenWidth),
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
                  Consumer(builder: (context, watch, _) {
                    return DropdownSearch<TodoTag>(
                      //validator: (v) => v == null ? "required field" : null,
                      searchBoxController: new TextEditingController(),
                      onAddItem: (String str) {
                        if (str.trim().length == 0) return;
                        context
                            .read(editTodoProvider.notifier)
                            .addTag(str)
                            .then((value) {
                          if (!value) {
                            ToastHelper.showToast('Duplicate Tag');
                          }
                        });
                        Navigator.pop(context);
                      },
                      compareFn: (a, b) {
                        return false;
                      },
                      mode: Mode.MENU,
                      showSelectedItem: false,
                      showSearchBox: true,
                      items: watch(GlobalProvider.todoTagProvider).tags,
                      itemAsString: (item) => item.id,
                      onChanged: (e) {
                        if (e != null) {
                          context.read(editTodoProvider.notifier).addTag(e.id);
                        }
                      },
                      popupBackgroundColor: Color(0xFF36302E),

                      dropdownBuilder: (_, tag, string) {
                        return Text('Select Tag',
                            style: Theme.of(context).textTheme.subtitle1);
                      },
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
                    );
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer(
              builder: (context, watch, child) {
                return Wrap(
                  children: [
                    ...watch(editTodoProvider)
                        .tags
                        .map((e) => e.id)
                        .toList()
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: InkWell(
                                onLongPress: () {
                                  context
                                      .read(editTodoProvider.notifier)
                                      .removeTag(e);
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  constraints: BoxConstraints(minWidth: 80),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(0.5)),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    e,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                  ],
                );
              },
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

class TodoTitleField extends StatelessWidget {
  const TodoTitleField(
      {Key? key,
      required this.editTodoProvider,
      required this.titleController,
      required this.node,
      this.onSavedField})
      : super(key: key);

  final AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState>
      editTodoProvider;
  final TextEditingController titleController;
  final FocusScopeNode node;
  final void Function(String?)? onSavedField;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        EditTodoState todoState = watch(editTodoProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: todoState.titleError == null
                    ? null
                    : Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Title",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w500),
                        controller: titleController,
                        onEditingComplete: () => node.nextFocus(),
                        onSaved: onSavedField,
                        onChanged: (str) {
                          if (todoState.titleError != null) {
                            context
                                .read(editTodoProvider.notifier)
                                .clearTitleError();
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.w500),
                          hintText: "(Required)",
                        )),
                  ),
                ],
              ),
            ),
            if (todoState.titleError != null)
              Padding(
                padding: EdgeInsets.only(top: 5, left: 5),
                child: Text(EditTodoError.titleEmptyError.str,
                    style: TextStyle(color: Colors.red[600], fontSize: 12)),
              ),
          ],
        );
      },
    );
  }
}
