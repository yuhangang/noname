import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.all(15),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "YOUR VOICE",
                  style: GoogleFonts.cinzel(
                      color: Colors.white,
                      fontSize: 70,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 10.0,
                          color: Color.fromARGB(20, 20, 20, 255),
                        ),
                      ]),
                ),
              ),
            ))
          ],
        ));
  }
}
