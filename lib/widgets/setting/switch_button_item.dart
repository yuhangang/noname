import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  MyClipper({required this.sizeRate, required this.offset});
  final double sizeRate;
  final Offset offset;

  @override
  Path getClip(Size size) {
    var path = Path()
      ..addOval(
        Rect.fromCircle(center: offset, radius: size.height * sizeRate),
      );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class SwitchButtonItem extends StatelessWidget {
  void Function(bool)? onchange;
  bool disabled;
  bool value;
  final String title;

  SwitchButtonItem({
    Key? key,
    required this.value,
    this.disabled = false,
    this.title = "NaN",
    this.onchange,
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
            Switch(
              value: this.value,
              onChanged: this.onchange ?? (bool val) {},
              activeColor: Theme.of(context).canvasColor,
            ),
          ],
        ),
      ),
    );
  }
}
