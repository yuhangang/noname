import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noname/commons/utils/notification/alert/alert_helper.dart';
import 'package:noname/screens/home/podcast_detail_screen.dart';
import 'package:noname/screens/podcast/widgets/avatar.dart';

class ScreenScreenTab extends StatelessWidget {
  const ScreenScreenTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: RefreshIndicator(
        displacement: 30,
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () => true);
        },
        child: ListView(
          children: [
            ...List.generate(8, (int index) => 5)
                .map((e) => careerItem(context)),
            SizedBox(
              height: screenHeight / 10,
            )
          ],
        ),
      ),
    );
  }

  Widget careerItem(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
          clipBehavior: Clip.antiAlias,
          onPressed: () {
            Navigator.pushNamed(context, PodcastDetailPage.route);
          },
          child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AvatarCustom().buildAvatar(
                      imgUrl:
                          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                  Text(
                    "Future of Dogecoins",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.button,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  randomColors(int index) {
    return index == 0
        ? Colors.green
        : index == 1
            ? Colors.lightBlue
            : index == 2
                ? Colors.yellow
                : index == 3
                    ? Colors.purpleAccent
                    : Colors.pinkAccent;
  }
}
