import 'package:flutter/material.dart';

class StopPodcastButton extends StatelessWidget {
  const StopPodcastButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        color: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
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
