import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todonote/commons/utils/notification/push_notification/push_notification.dart';
import 'package:todonote/views/home/home_page.dart';
import 'package:todonote/views/intro_slider/widgets/slider.dart';
import 'package:todonote/views/intro_slider/widgets/slider_item.dart';
import 'package:todonote/views/intro_slider/widgets/dot_indicator/dot_indicator.dart';
import 'package:todonote/views/intro_slider/widgets/dot_indicator/dots_decorator.dart';
import 'package:todonote/views/intro_slider/widgets/transparent_image.dart';
import 'package:todonote/views/login/login_page.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';

class IntroPage extends HookWidget {
  static const route = "/intro-page";
  final PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    final index = useState<double>(0);
    Function onPageChanged2 = (idx) {
      index.value = idx.toDouble();
    };

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        child: Stack(
          children: [
            AnimatedPositioned(
              left: 0 - index.value * 200,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 1500),
              child: Container(
                width: MediaQuery.of(context).size.width + 400,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 10),
                child: Center(
                  child: FadeInImage(
                    placeholder: MemoryImage(TransparentImage.tranparentImage),
                    image: const AssetImage(
                        "assets/images/illustrations/mockup_homepage_vertical.png"),
                    fit: BoxFit.fitHeight,
                    height: MediaQuery.of(context).size.height * 0.7,
                    alignment: const FractionalOffset(0.5, 0),
                  ),
                ),
              ),
            ),
            //Container(
            //  decoration: BoxDecoration(
            //      gradient: LinearGradient(
            //          begin: Alignment.topCenter,
            //          end: Alignment.bottomCenter,
            //          colors: [
            //        Colors.black.withOpacity(0.5),
            //        Colors.black.withOpacity(0.1),
            //        Colors.transparent
            //      ])),
            //),
            IntroSlider(
                pageController: _pageController,
                onPageChanged2: onPageChanged2),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  DotsIndicator(
                    dotsCount: 3,
                    position: index.value,
                    decorator: DotsDecorator(
                      color: Colors.white.withOpacity(0.7),
                      activeColor: Colors.white,
                      size: const Size.fromRadius(6.0),
                      activeSize: const Size.fromRadius(10.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      Auth auth = watch(GlobalProvider.authProvider);
                      return TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, HomePage.route);
                          },
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text("continue",
                                style: GoogleFonts.sourceSansPro(
                                    letterSpacing: 1,
                                    color: const Color(0xFF000000),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 20.0,
                                        color: const Color.fromARGB(
                                            20, 20, 20, 255),
                                      ),
                                    ])),
                          ));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
