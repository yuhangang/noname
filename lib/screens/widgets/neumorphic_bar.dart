import 'dart:math';

import 'package:flutter/material.dart';

class NeumorphicBar extends StatefulWidget {
  GlobalKey<InnerContainerState> innerContainerState = new GlobalKey();

  NeumorphicBar(
      {Key key,
      @required this.width,
      @required this.height,
      value,
      this.onChange,
      this.text,
      this.color,
      this.linearGradient})
      : super(key: key) {
    this.value = value == null ? 30.0 : 100.0 - value;
  }
  final LinearGradient linearGradient;
  final Function onChange;
  final double width;
  final double height;

  /// Value from 1.0 to 0.0
  double value;

  final String text;
  final Color color;

  @override
  _NeumorphicBarState createState() => _NeumorphicBarState();
}

class _NeumorphicBarState extends State<NeumorphicBar> {
  double percentage = 0.0;

  double initial = 0.0;
  @override
  void initState() {
    percentage = widget.value;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final innerContainerWidth = widget.width * 0.95;
    final innerContainerHeight = widget.height * (1 - percentage / 100) * 0.96;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onPanStart: (DragStartDetails details) {
            initial = details.globalPosition.dy;
          },
          onPanUpdate: (DragUpdateDetails details) {
            double distance = details.globalPosition.dy - initial;
            double percentageAddition = distance / 100;

            print('distance ' + distance.toString());

            setState(() {
              print('percentage ' +
                  (percentage + percentageAddition)
                      .clamp(0.0, 100.0)
                      .toString());
              percentage = (percentage + percentageAddition)
                  .clamp(0.0, 100.0)
                  .roundToDouble();

              //if (percentage > 95) percentage = 100;
            });
          },
          onPanEnd: (DragEndDetails details) {
            initial = 0;
          },
          child: Container(
            height: widget.height * 1.01,
            width: widget.width,
            child: Stack(
              children: <Widget>[
                DugContainer(
                  width: widget.width,
                  height: widget.height,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(95.0),
                  child: InnerContainer(
                    width: innerContainerWidth,
                    height: innerContainerHeight,
                    color: widget.color,
                    linearGradient: widget.linearGradient,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        if (widget.text != null)
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.blueGrey[300],
            ),
          ),
      ],
    );
  }
}

class InnerContainer extends StatefulWidget {
  InnerContainer(
      {Key key,
      @required this.height,
      @required this.width,
      this.color,
      this.linearGradient})
      : super(key: key);

  num height;
  num width;
  final Color color;
  final LinearGradient linearGradient;

  @override
  InnerContainerState createState() => InnerContainerState();
}

class InnerContainerState extends State<InnerContainer> {
  double _percentage = 0;
  void changeInnerContainerHeight(double percentage) =>
      setState(() => _percentage = percentage);

  @override
  Widget build(BuildContext context) {
    final innerContainerWidth = widget.width * 0.95;
    final innerContainerHeight = widget.height * (1 - _percentage / 100) * 0.96;

    return Opacity(
      opacity: widget.height < widget.width * 0.85 / 1.5 ? 0 : 1,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.width / 5),
          child: Container(
            height: widget.height * 600 / 896,
            width: widget.width * 0.85,
            decoration: BoxDecoration(
              shape: widget.height < widget.width * 0.85
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              color: widget.color ?? Color.fromRGBO(235, 233, 232, 1),
              borderRadius: widget.height < widget.width * 0.85
                  ? null
                  : BorderRadius.circular(95.0),
              gradient: widget.linearGradient ?? null,
              boxShadow: [
                BoxShadow(
                  offset: Offset(1.5, 1.5),
                  color: Colors.black38,
                  blurRadius: 2,
                ),
                BoxShadow(
                  offset: Offset(-1.5, -1.5),
                  color: widget.color?.withOpacity(0.95) ??
                      Colors.white.withOpacity(0.85),
                  blurRadius: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DugContainer extends StatelessWidget {
  const DugContainer({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);
  final num height;
  final num width;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height * 600 / 896,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: exteriorShadow,
              offset: Offset(0.0, 0.0),
            ),
            BoxShadow(
              color: interiorShadow,
              offset: Offset(0.0, 0.0),
              spreadRadius: -1.0,
              blurRadius: 11.0,
            ),
          ],
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}

Color exteriorShadow = Colors.grey[400];
Color interiorShadow = Colors.grey[200];
