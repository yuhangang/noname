import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:noname/commons/utils/notification/push_notification/push_notification.dart';
import 'package:noname/commons/utils/notification/push_notification/src/notification_show/notification_helper.dart';

import 'package:noname/screens/podcast/widgets/avatar.dart';
import 'package:noname/screens/podcast/widgets/rolling_stone.dart';

class AudioPlayerSample extends StatefulWidget {
  @override
  _AudioPlayerSampleState createState() => _AudioPlayerSampleState();
}

class _AudioPlayerSampleState extends State<AudioPlayerSample> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero,
        () => LocalNotificationHelper.showOngoingNotification(
            message: 'this message', imageUrl: "fdsf"));
    return NeumorphicTheme(
        themeMode: ThemeMode.light,
        theme: NeumorphicThemeData(
          defaultTextColor: Color(0xFF3E3E3E),
          baseColor: Color(0xFFDDE6E8),
          intensity: 0.5,
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        darkTheme: neumorphicDefaultDarkTheme.copyWith(
            defaultTextColor: Colors.white70),
        child: _Page());
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  bool _useDark = false;
  bool _follow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeumorphicBackground(
        child: Column(
          children: <Widget>[
            SafeArea(child: _buildTopBar(context)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RollingStone(),
                  _buildImage(context),
                  SizedBox(height: 20),
                  _buildTitle(context),
                  SizedBox(height: 60),
                  _buildControlsBar(context),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: const EdgeInsets.all(8.0),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Now Playing",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              padding: const EdgeInsets.all(15.0),
              onPressed: () {
                setState(() {
                  _follow = !_follow;
                  //_useDark = !_useDark;
                  //NeumorphicTheme.of(context).themeMode =
                  //    _useDark ? ThemeMode.dark : ThemeMode.light;
                });
              },
              icon: Icon(
                _follow ? Icons.favorite : Icons.favorite_border,
                size: 25,
                color: _follow ? Colors.red[600] : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AvatarCustom(
                size: 50,
                url:
                    "https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp")
            .buildAvatarWithBadge(Icons.mic_off, iconColor: Colors.redAccent),
        SizedBox(
          width: 10,
        ),
        AvatarCustom(
                size: 50,
                url:
                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260")
            .buildAvatar()
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Blinding Lights",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 34,
                color: NeumorphicTheme.defaultTextColor(context))),
        const SizedBox(
          height: 4,
        ),
        Text("The Weeknd x Machine",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: NeumorphicTheme.defaultTextColor(context))),
      ],
    );
  }

  Widget _buildControlsBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        NeumorphicRoundButton(icon: CupertinoIcons.play_arrow_solid),
        const SizedBox(
          width: 15,
        ),
        NeumorphicRoundButton(icon: CupertinoIcons.volume_mute),
        const SizedBox(
          width: 15,
        ),
        NeumorphicRoundButton(icon: Icons.share),
      ],
    );
  }
}

class NeumorphicRoundButton extends StatefulWidget {
  final IconData icon;
  final void Function()? onPressed;
  NeumorphicRoundButton({required this.icon, this.onPressed});
  @override
  _NeumorphicRoundButtonState createState() => _NeumorphicRoundButtonState();
}

class _NeumorphicRoundButtonState extends State<NeumorphicRoundButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: const EdgeInsets.all(12.0),
      onPressed: widget.onPressed ?? () {},
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: Icon(
        widget.icon,
        size: 25,
        color: Colors.black,
      ),
    );
  }
}
