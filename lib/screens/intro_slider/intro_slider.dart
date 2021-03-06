import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noname/commons/utils/notification/notification_helper.dart';
import 'package:noname/screens/intro_slider/widgets/slider.dart';
import 'package:noname/screens/intro_slider/widgets/slider_item.dart';
import 'package:noname/screens/intro_slider/widgets/dot_indicator/dot_indicator.dart';
import 'package:noname/screens/intro_slider/widgets/dot_indicator/dots_decorator.dart';
import 'package:noname/screens/intro_slider/widgets/transparent_image.dart';
import 'package:noname/screens/login/login_page.dart';

class IntroPage extends HookWidget {
  static const route = "/intro-page";
  final PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    final index = useState<double>(0);
    Function onPageChanged2 = (idx) {
      LocalNotificationHelper.showNotification(message: "from intro slider");
      index.value = idx.toDouble();
    };

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            AnimatedPositioned(
              left: 0 - index.value * 50,
              curve: Curves.easeOutExpo,
              duration: const Duration(milliseconds: 2000),
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                child: FadeInImage(
                  placeholder: MemoryImage(TransparentImage.tranparentImage),
                  image: const AssetImage("assets/images/intro.jpg"),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  alignment: const FractionalOffset(0.5, 0),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.1),
                    Colors.transparent
                  ])),
            ),
            IntroSlider(
                pageController: _pageController,
                onPageChanged2: onPageChanged2),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 10,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  DotsIndicator(
                    dotsCount: 3,
                    position: index.value,
                    decorator: DotsDecorator(
                      color: Colors.white.withOpacity(0.5),
                      activeColor: Colors.white,
                      size: const Size.fromRadius(6.0),
                      activeSize: const Size.fromRadius(8.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.route);
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("SKIP",
                            style: GoogleFonts.sourceSansPro(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 10.0,
                                    color:
                                        const Color.fromARGB(20, 20, 20, 255),
                                  ),
                                ])),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
