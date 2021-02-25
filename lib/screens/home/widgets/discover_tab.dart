import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:noname/screens/home/podcast_detail_screen.dart';
import 'package:noname/screens/home/widgets/bar_chart.dart';
import 'package:noname/screens/podcast/widgets/avatar.dart';
import 'package:noname/screens/podcast/widgets/podcast_summary_dialog.dart';

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({
    Key key,
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
            ...List.generate(4, (int index) => 5)
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
        child: FlatButton(
          clipBehavior: Clip.antiAlias,
          onPressed: () {
            Navigator.pushNamed(context, PodcastDetailPage.route);
          },
          padding: EdgeInsets.all(0),
          child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Future of Dogecoins",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'For implementing the animation, we will be using the dashed_circle package for creating the dashed lines around the image. The first step is to add the package to pubspec.yaml as shown below',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  AvatarCustom().stackedAvatar(
                      link1:
                          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                      link2:
                          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("290 "),
                      Icon(CupertinoIcons.person),
                      SizedBox(
                        width: 15,
                      ),
                      Text("51 "),
                      Icon(CupertinoIcons.chat_bubble),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: "Custom Dialog Demo",
                                    descriptions:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                                    text: "Yes",
                                  );
                                });
                          },
                          child: Icon(CupertinoIcons.info))
                    ],
                  ),
                  //PollBarChart(
                  //  options: [
                  //    new Options(optionName: "fdrdffd", count: 2),
                  //    new Options(optionName: "fdffd", count: 1),
                  //  ],
                  //  barColors: List.generate(2, (index) => randomColors(index)),
                  //)
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
