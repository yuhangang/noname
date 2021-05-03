import 'package:flutter/material.dart';
import 'package:todonote/views/widgets/badge/badge_animation_type.dart';
import 'package:todonote/views/widgets/badge/badge_position.dart';
import 'package:todonote/views/widgets/badge/badge_positioned.dart';
import 'package:todonote/views/widgets/badge/badge_shape.dart';

class Badge extends StatefulWidget {
  final Widget badgeContent;
  final Color badgeColor;
  final Widget child;
  final double elevation;
  final bool toAnimate;
  final BadgePosition? position;
  final BadgeShape shape;
  final EdgeInsetsGeometry padding;
  final Duration animationDuration;
  final BorderRadiusGeometry borderRadius;
  final AlignmentGeometry alignment;
  final BadgeAnimationType animationType;
  final bool showBadge;
  final bool ignorePointer;
  final BorderSide borderSide;

  Badge({
    this.badgeContent = const SizedBox(),
    this.child = const SizedBox(),
    this.badgeColor = Colors.red,
    this.elevation = 2,
    this.toAnimate = true,
    this.position,
    this.shape = BadgeShape.circle,
    this.padding = const EdgeInsets.all(5.0),
    this.animationDuration = const Duration(milliseconds: 500),
    this.borderRadius = BorderRadius.zero,
    this.alignment = Alignment.center,
    this.animationType = BadgeAnimationType.slide,
    this.showBadge = true,
    this.ignorePointer = false,
    this.borderSide = BorderSide.none,
  });

  @override
  BadgeState createState() {
    return BadgeState();
  }
}

class BadgeState extends State<Badge> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Tween<Offset> _positionTween = Tween(
    begin: const Offset(-0.5, 0.9),
    end: const Offset(0.0, 0.0),
  );
  final Tween<double> _scaleTween = Tween<double>(begin: 0.1, end: 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    if (widget.animationType == BadgeAnimationType.slide) {
      _animation = CurvedAnimation(
          parent: _animationController, curve: Curves.elasticOut);
    } else if (widget.animationType == BadgeAnimationType.scale) {
      _animation = _scaleTween.animate(_animationController);
    } else if (widget.animationType == BadgeAnimationType.fade) {
      _animation =
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    }

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.alignment,
      clipBehavior: Clip.none,
      children: [
        widget.child,
        BadgePositioned(
          position: widget.position,
          child: widget.ignorePointer
              ? IgnorePointer(child: _getBadge())
              : _getBadge(),
        ),
      ],
    );
  }

  Widget _getBadge() {
    final border = widget.shape == BadgeShape.circle
        ? CircleBorder(side: widget.borderSide)
        : RoundedRectangleBorder(
            side: widget.borderSide,
            borderRadius: widget.borderRadius,
          );

    Widget badgeView() {
      return AnimatedOpacity(
        child: Material(
          shape: border,
          elevation: widget.elevation,
          color: widget.badgeColor,
          child: Padding(
            padding: widget.padding,
            child: widget.badgeContent,
          ),
        ),
        opacity: widget.showBadge ? 1 : 0,
        duration: Duration(milliseconds: 200),
      );
    }

    if (widget.toAnimate) {
      if (widget.animationType == BadgeAnimationType.slide) {
        return SlideTransition(
          position: _positionTween.animate(_animation),
          child: badgeView(),
        );
      } else if (widget.animationType == BadgeAnimationType.scale) {
        return ScaleTransition(
          scale: _animation,
          child: badgeView(),
        );
      } else if (widget.animationType == BadgeAnimationType.fade) {
        return FadeTransition(
          opacity: _animation,
          child: badgeView(),
        );
      }
    }

    return badgeView();
  }

  @override
  void didUpdateWidget(Badge oldWidget) {
    if (widget.badgeContent is Text && oldWidget.badgeContent is Text) {
      final newText = widget.badgeContent as Text;
      final oldText = oldWidget.badgeContent as Text;
      if (newText.data != oldText.data) {
        _animationController.reset();
        _animationController.forward();
      }
    }

    if (widget.badgeContent is Icon && oldWidget.badgeContent is Icon) {
      final newIcon = widget.badgeContent as Icon;
      final oldIcon = oldWidget.badgeContent as Icon;
      if (newIcon.icon != oldIcon.icon) {
        _animationController.reset();
        _animationController.forward();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
