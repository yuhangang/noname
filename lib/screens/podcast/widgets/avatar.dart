import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:noname/constants/app_config.dart';
import 'package:noname/screens/widgets/badge/badge.dart';
import 'package:noname/screens/widgets/badge/badge_position.dart';

class AvatarCustom {
  final String url;
  final BoxFit fit;
  final double size;

  const AvatarCustom({this.url = "", this.fit = BoxFit.cover, this.size = 40});

  Widget buildAvatarWithBadge(IconData icon,
          {Color iconColor = Colors.black, Color badgeColor = Colors.white}) =>
      Badge(
        position: BadgePosition.bottomEnd(),
        badgeContent:
            Icon(icon, color: Colors.red, size: max(this.size / 2.7, 16)),
        badgeColor: Colors.white,
        child: buildAvatar(),
      );

  Widget buildAvatar({String imgUrl}) => Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
        ),
        child: Container(
            height: this.size,
            width: this.size,
            child: FadeInImage.assetNetwork(
                placeholder: AppConfig.userImgPlaceHolderUrl,
                image: imgUrl ?? this.url,
                fit: fit)),
      );

  Widget stackedAvatar({String link1, String link2}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: buildAvatar(imgUrl: link2)),
            Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: buildAvatar(imgUrl: link1),
            ),
          ],
        ),
      );
}

enum PlayerStatus { muted, isHost, speaking, online }
