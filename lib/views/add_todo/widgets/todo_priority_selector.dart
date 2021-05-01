import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';

class PrioritySelector extends StatelessWidget {
  void Function()? onchange;
  bool disabled;
  final String title;
  AutoDisposeStateNotifierProvider<EditTodoProvider, EditTodoState> provider;
  TodoImportance selectedItem;
  PrioritySelector({
    Key? key,
    this.disabled = false,
    this.title = "NaN",
    this.onchange,
    required this.selectedItem,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !disabled
        ? buildSwitch(context)
        : IgnorePointer(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).accentColor.withOpacity(0.2),
                  BlendMode.xor),
              child: buildSwitch(context),
            ),
          );
  }

  Widget buildSwitch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 16),
                  ))),
          const SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...TodoImportance.values.map(
                (e) => Tooltip(
                  message: e.itemAsString,
                  preferBelow: false,
                  child: Container(
                    height: 30,
                    width: 30,
                    //padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: e == selectedItem ? Colors.blueGrey : null,
                        border: Border.all(color: Colors.blueGrey)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () => context
                          .read(provider.notifier)
                          .changeTodoImportance(e),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            e.itemAsString[0].toUpperCase(),
                            style: TextStyle(
                                color: e != selectedItem
                                    ? Colors.blueGrey
                                    : Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
