import 'package:flutter/material.dart';

class StopPodcastButton extends StatelessWidget {
  const StopPodcastButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.3),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        onPressed: () {},
        child: Text(
          "STOP",
          style: TextStyle(color: Colors.white, shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(1, 1),
              blurRadius: 5,
            ),
          ]),
        ),
      ),
    );
  }
}
