import 'package:flutter/material.dart';
import 'package:todonote/navigation/custom_page_route/custom_page_route.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/views/add_todo/add_todo_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoTaskTile extends StatelessWidget {
  const TodoTaskTile({
    Key? key,
    required this.context,
    required this.e,
  }) : super(key: key);

  final BuildContext context;
  final TodoTask e;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashColor: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 2),
      onLongPress: () {
        Navigator.of(context).push(
            CustomPageRoute.verticalTransition(AddEditTodoScreen(todoTask: e)));
      },
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).primaryColorDark.withOpacity(0.05)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.2),
                      ]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(e.title,
                          style: Theme.of(context).textTheme.bodyText1!),
                      Container(
                        height: 20,
                        width: 20,
                        //padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blueGrey)),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              e.importance.itemAsString[0].toUpperCase(),
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read(GlobalProvider.todoProvider.notifier)
                        .removeTodo(e);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.done_sharp),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
