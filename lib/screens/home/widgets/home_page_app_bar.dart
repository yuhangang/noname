

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:noname/screens/search_screen/seach_screen.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 45,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        iconSize: 30,
        splashRadius: 25,
        padding: const EdgeInsets.all(10),
        splashColor: Colors.white.withOpacity(0.3),
        onPressed: () {
          Navigator.pushNamed(context, SearchScreen.route);
        },
        icon: Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.

      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "UTHOPIA",
              style:
                  ThemeData.light().textTheme.headline1!.copyWith(fontSize: 25),
            ),
            SizedBox(
              width: 15,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://miro.medium.com/max/700/1*InbuykHMMQcVkNSC_uNp0A.png",
              ),
              radius: 15,
              backgroundColor:
                  SchedulerBinding.instance!.window.platformBrightness ==
                          Brightness.light
                      ? Colors.grey[100]
                      : Colors.grey[800],
            ),
            SizedBox(
              width: 20,
            ),
          ],
        )
      ],
    );
  }
}
