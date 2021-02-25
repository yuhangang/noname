import 'package:flutter/material.dart';

// Our Category List need StateFullWidget
// I can use Provider on it, Then we dont need StatefulWidget

class Categories extends StatefulWidget {
  final PageController parentPageController;
  final Color highlightColor;
  final Color fontColor;
  final Color fontFocusColor;
  final List<String> categories;
  Categories(
      {Key key,
      this.parentPageController,
      this.categories,
      this.fontColor,
      this.highlightColor,
      this.fontFocusColor})
      : super(key: key);
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  // By default first one is selected
  int selectedIndex = 0;
  ScrollController listViewScrollController = new ScrollController();

  void changeCategoryIndex(int index) {
    print(index >= widget.categories.length - 1);
    if (index == 0) {
      if (listViewScrollController.position.pixels > 0) {
        listViewScrollController.animateTo(0,
            duration: Duration(
                milliseconds:
                    (8 * listViewScrollController.position.pixels - 0).round()),
            curve: Curves.easeOut);
      }
    } else if (index >= widget.categories.length - 1) {
      if (listViewScrollController.position.maxScrollExtent >
          listViewScrollController.position.pixels) {
        print("true");
        listViewScrollController.animateTo(
            listViewScrollController.position.maxScrollExtent,
            duration: Duration(
                milliseconds:
                    (8 * listViewScrollController.position.maxScrollExtent -
                            listViewScrollController.position.pixels)
                        .round()),
            curve: Curves.easeOut);
      }
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 35, // 35
        child: ListView.builder(
          controller: listViewScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.categories.length + 1,
          itemBuilder: (context, index) => index == widget.categories.length
              ? SizedBox(
                  width: 10,
                )
              : buildCategoriItem(index),
        ),
      ),
    );
  }

  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        if ((index - selectedIndex).abs() < 2) {
          widget.parentPageController.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else {
          widget.parentPageController.jumpToPage(index);
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20, //20
          vertical: 5, //5
        ),
        decoration: BoxDecoration(
            color: selectedIndex == index
                ? Colors.brown[800].withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              16, // 16
            )),
        child: Text(
          widget.categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.black : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
