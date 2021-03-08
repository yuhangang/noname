import 'package:flutter/material.dart';

abstract class CustomPageRoute {
  static Route verticalTransition(Widget targetPage) {
    return PageRouteBuilder(
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => targetPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeOutCubic;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var animatedOpactiy = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: Opacity(
              opacity: 1 - animation.drive(animatedOpactiy).value.dy,
              child: child),
        );
      },
    );
  }
}
