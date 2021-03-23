import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedBottomNaviBar extends StatelessWidget {
  const AnimatedBottomNaviBar(
      {Key? key,
      required this.bottomNaviController,
      required this.bottomnavigationkey,
      required this.index,
      required this.onTapItem})
      : super(key: key);
  final void Function(int) onTapItem;
  final AnimationController bottomNaviController;
  final GlobalKey<State<StatefulWidget>> bottomnavigationkey;
  final int index;

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
              child: SizedBox(
                height: 54,
                child: BottomNavigationBar(
                  key: bottomnavigationkey,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  currentIndex: index,
                  onTap: onTapItem,
                  elevation: 0,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: "dashboard"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.chart_bar), label: "stat"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.globe), label: "explore"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.news), label: "article"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person), label: "me")
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
