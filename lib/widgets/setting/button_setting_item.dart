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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(title))),
            const SizedBox(
              width: 10,
            ),
            InkWell(
                onTap: onTapItem,
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
