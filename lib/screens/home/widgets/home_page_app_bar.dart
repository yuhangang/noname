import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/screens/account/account_page.dart';
import 'package:noname/screens/search_screen/search_screen.dart';
import 'package:noname/widgets/icon_button.dart';

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
      leading: CustomIconButton(
        onPressed: () {
          Navigator.of(context)
              .push(CustomPageRoute.verticalTransition(SearchScreen()));
        },
        icon: CupertinoIcons.search,
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
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AccountPage.route);
              },
              child: CircleAvatar(
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
