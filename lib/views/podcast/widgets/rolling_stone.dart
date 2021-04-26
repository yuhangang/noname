import 'dart:math';

import 'package:flutter/material.dart';

class RollingStone extends StatefulWidget {
  const RollingStone({
    Key? key,
  }) : super(key: key);

  @override
  _RollingStoneState createState() => _RollingStoneState();
}

class _RollingStoneState extends State<RollingStone>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Image earthImage;
  @override
  void initState() {
    earthImage = Image.asset('assets/images/magnetic-tape-reel.png',
        fit: BoxFit.fitWidth);
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20))
          ..repeat();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(earthImage.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenWidth / 10),
      child: Container(
        width: screenWidth * 0.7,
        height: screenWidth * 0.7,
        child: Center(
          child: Stack(
            children: [
              ClipOval(
                child: Container(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * pi,
                        child: earthImage,
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
