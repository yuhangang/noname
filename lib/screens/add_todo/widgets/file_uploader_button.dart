import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:noname/commons/utils/toast/show_toast.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';

class FileUploaderButton extends StatelessWidget {
  const FileUploaderButton({
    Key? key,
    required this.isNew,
    required this.editTodoProvider,
    required this.screenWidth,
  }) : super(key: key);

  final bool isNew;
  final AutoDisposeStateNotifierProvider<EditTodoProvider> editTodoProvider;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FilePicker.platform.pickFiles().then((result) {
          if (result != null) {
            File file = File(result.files.single.path!);
            print(file);
          } else {
            // User canceled the picker
          }
        });
      },
      onLongPress: () {
        print("clear");
      },
      borderRadius: BorderRadius.circular(3),
      child: Consumer(
        builder: (context, watch, child) {
          EditTodoState todoState = watch(editTodoProvider.state);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    border: todoState.noStartDateError &&
                            todoState.noStartAfterEndError
                        ? null
                        : Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(3),
                    color:
                        Theme.of(context).primaryColorDark.withOpacity(0.04)),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        CupertinoIcons.folder,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Upload File (max 10mb)",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 16, color: Colors.grey)),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
