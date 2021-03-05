

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:noname/screens/intro_slider/widgets/slider_item.dart';

class IntroSlider extends HookWidget {
  const IntroSlider({
    required PageController pageController,
    required this.onPageChanged2,
  }) : _pageController = pageController;

  final PageController _pageController;
  final Function onPageChanged2;

  @override
  Widget build(BuildContext context) {
    final opacity = useState<double>(0);
    Future.delayed(Duration.zero, () {
      opacity.value = 1;
    });
    return AnimatedOpacity(
      opacity: opacity.value,
      duration: Duration(milliseconds: 3000),
      curve: Curves.easeInExpo,
      child: PageView.builder(
          itemCount: 3,
          controller: _pageController,
          onPageChanged: onPageChanged2 as void Function(int)?,
          itemBuilder: (_, index) {
            return SliderItem();
          }),
    );
  }
}
