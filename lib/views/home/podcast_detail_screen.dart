import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todonote/views/search_screen/channel_screens.dart';
import 'package:todonote/views/home/widgets/podcast_snippet.dart';
import 'package:todonote/views/podcast/widgets/avatar.dart';

class PodcastDetailPage extends StatelessWidget {
  static const route = "/podcast";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,

        elevation: 0,
        backgroundColor: Colors.transparent,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.

        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PODCAST",
                style: ThemeData.light()
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 25),
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
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AvatarCustom(
                        url:
                            "https://miro.medium.com/fit/c/96/96/1*PI69tTIppYCRALRqfEasCw.jpeg",
                        size: 60)
                    .buildAvatarWithBadge(CupertinoIcons.add),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            textStyle: TextStyle(color: Colors.grey[800]),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            side: BorderSide(
                                color: Colors.grey[800]!,
                                width: 1.5,
                                style: BorderStyle.solid)),
                        child: Text(true ? "follow" : "unfollow")),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          shape: CircleBorder(),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.all(0)),
                      child: LayoutBuilder(builder: (context, constraint) {
                        return new Icon(CupertinoIcons.bell_circle,
                            size: 40, color: Colors.grey[800]);
                      }),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
