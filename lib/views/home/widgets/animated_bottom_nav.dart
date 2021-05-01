import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedBottomNaviBar extends StatelessWidget {
  const AnimatedBottomNaviBar(
      {Key? key,
      required this.bottomNaviController,
      required this.bottomnavigationkey,
      required this.index,
      required this.onTapItem,
      required this.items})
      : super(key: key);
  final void Function(int) onTapItem;
  final AnimationController bottomNaviController;
  final GlobalKey<State<StatefulWidget>> bottomnavigationkey;
  final int index;

  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedBuilder(
          animation: bottomNaviController,
          builder: (_, child) {
            return SizeTransition(
              axisAlignment: -1,
              sizeFactor: bottomNaviController,
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops: [
                  0,
                  0.4,
                  1
                ], colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                  Theme.of(context).scaffoldBackgroundColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: BottomNavigationBar(
                  key: bottomnavigationkey,
                  backgroundColor: Colors.transparent,
                  currentIndex: index,
                  onTap: onTapItem,
                  elevation: 0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: items,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
