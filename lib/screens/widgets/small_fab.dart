import 'package:flutter/material.dart';

class SmallFAB extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final double positionR;
  final double positionB;
  final String heroTag;
  const SmallFAB({
    required this.icon,
    required this.onTap,
    required this.positionB,
    required this.positionR,
    required this.heroTag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: this.positionR,
      bottom: this.positionB,
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
