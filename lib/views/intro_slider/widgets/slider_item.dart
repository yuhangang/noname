import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "todoNote",
              style: GoogleFonts.openSans(
                fontSize: 70,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Color(0xFF000000),
                fontWeight: FontWeight.w600,
                //shadows: [
                //  Shadow(
                //    offset: const Offset(2, 2),
                //    blurRadius: 10.0,
                //    color: const Color.fromARGB(20, 20, 20, 255),
                //  ),
                //]
              ),
            ),
          ),
        ))
      ],
    ));
  }
}
