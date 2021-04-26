import 'package:flutter/material.dart';

class SmallFAB extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final double? right;
  final double? bottom;
  final double? top;
  final double? left;
  final String heroTag;
  const SmallFAB({
    required this.icon,
    required this.onTap,
    this.bottom,
    this.right,
    this.top,
    this.left,
    required this.heroTag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: this.right,
      bottom: this.bottom,
      child: FloatingActionButton(
        heroTag: Text(this.heroTag),
        elevation: 1,
        hoverElevation: 3,
        focusElevation: 3,
        highlightElevation: 3,
        mini: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          this.icon,
        ),
        onPressed: this.onTap,
      ),
    );
  }
}
