/*
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todonote/constants/const_styles.dart';
import 'package:todonote/views/podcast/neumorphic_player.dart';
import 'package:todonote/views/widgets/badge/badge.dart';
import 'package:todonote/views/widgets/badge/badge_position.dart';

class PodcastPage extends StatelessWidget {
  static const String route = "/podcast-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.podcastPageColor,
      body: Container(child: AudioPlayerSample()),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Badge(
          position: BadgePosition.bottomEnd(),
          badgeContent: Icon(
            Icons.mic_off,
            color: Colors.red,
          ),
          badgeColor: Colors.white,
          child: Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            child: Container(
                height: 60,
                width: 60,
                child: Image.network(
                  "https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp",
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: Container(
              height: 60,
              width: 60,
              child: Image.network(
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                fit: BoxFit.cover,
              )),
        ),
      ],
    );
  }
}

*/
