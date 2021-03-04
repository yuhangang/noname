import 'package:flutter/material.dart';
import 'package:noname/screens/home/widgets/stop_podcast_button.dart';
import 'package:noname/screens/podcast/podcast_page.dart';

class PodcastSnippet extends StatelessWidget {
  const PodcastSnippet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Colors.grey[800]),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: () {
                  Navigator.of(context).push(_createPodcastRoute());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(250, 250, 240, 1),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 30.0,
                          color: Color.fromRGBO(10, 0, 0, 0.2),
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Hosting an Podcast"), StopPodcastButton()],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Route _createPodcastRoute() {
  return PageRouteBuilder(
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => PodcastPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
