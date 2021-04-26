import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Our Category List need StateFullWidget
// I can use Provider on it, Then we dont need StatefulWidget

class CategoryTabBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<CustomTabBarState> categoryState;
  final PageController parentPageController;
  final Color? highlightColor;
  final Color? fontColor;
  final Color? fontFocusColor;
  final List<String> categories;
  @override
  Size get preferredSize => new Size.fromHeight(55);

  const CategoryTabBar(
      {Key? key,
      required this.categoryState,
      required this.parentPageController,
      required this.categories,
      this.fontColor,
      this.highlightColor,
      this.fontFocusColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: this.preferredSize,
      child: CustomTabBar(
        key: categoryState,
        categories: categories,
        parentPageController: parentPageController,
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  final PageController? parentPageController;
  final Color? highlightColor;
  final Color? fontColor;
  final Color? fontFocusColor;
  final List<String> categories;
  CustomTabBar(
      {Key? key,
      this.parentPageController,
      required this.categories,
      this.fontColor,
      this.highlightColor,
      this.fontFocusColor})
      : super(key: key);
  @override
  CustomTabBarState createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar> {
  // By default first one is selected
  int selectedIndex = 0;
  ScrollController tabBarController = new ScrollController();
  double widthPerItem = 100;

  void changeCategoryIndex(int index) {
    if (selectedIndex > index) {
      if (tabBarController.position.pixels > 0) {
        tabBarController.animateTo(
            max(
                tabBarController.position.pixels -
                    widthPerItem * (selectedIndex - index),
                0),
            duration: Duration(milliseconds: (600 * (selectedIndex - index))),
            curve: Curves.easeOutExpo);
      }
    } else if (selectedIndex < index) {
      if (tabBarController.position.maxScrollExtent >
          tabBarController.position.pixels) {
        tabBarController.animateTo(
            min(
                tabBarController.position.pixels +
                    widthPerItem * (index - selectedIndex),
                tabBarController.position.maxScrollExtent),
            duration: Duration(milliseconds: (600 * (index - selectedIndex))),
            curve: Curves.easeOutExpo);
      }
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // 35
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark.withOpacity(0.12),
          borderRadius: BorderRadius.circular(
            100, // 16
          )),

      child: SingleChildScrollView(
        controller: tabBarController,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(widget.categories.length, (index) => 0 + index)
                .map((e) => buildCategoriItem(e))
          ],
        ),
      ),
    );
  }

  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        if ((index - selectedIndex).abs() < 2) {
          widget.parentPageController!.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic);
        } else {
          widget.parentPageController!.jumpToPage(index);
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(
          horizontal: 20, //20
          //5
        ),
        decoration: BoxDecoration(
            color: selectedIndex == index
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              100, // 16
            )),
        child: Text(
          widget.categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColorDark.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
