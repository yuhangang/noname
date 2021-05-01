import 'package:flutter/material.dart';

class ButtonSettingItem extends StatelessWidget {
  const ButtonSettingItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTapItem,
  }) : super(key: key);
  final void Function() onTapItem;
  final Icon icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
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
            InkWell(
                onTap: onTapItem,
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon,
                )),
          ],
        ),
      ),
    );
  }
}
