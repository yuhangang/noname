import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key,
      this.size = 28,
      required this.icon,
      required this.onPressed,
      this.color})
      : super(key: key);
  final double size;
  final IconData icon;
  final void Function() onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: this.onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          this.icon,
          size: this.size,
          color: this.color ?? Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
