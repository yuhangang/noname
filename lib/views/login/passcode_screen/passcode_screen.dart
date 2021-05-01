library passcode_screen;

export 'circle.dart';
export 'keyboard.dart';
export 'shake_curve.dart';
export 'passcode_screen_status.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:noname/commons/utils/toast/show_toast.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/views/home/home_page.dart';
import 'package:noname/views/login/passcode_screen/circle.dart';
import 'package:noname/views/login/passcode_screen/keyboard.dart';
import 'package:noname/views/login/passcode_screen/passcode_screen_status.dart';
import 'package:noname/views/login/passcode_screen/shake_curve.dart';
import 'package:noname/widgets/app_bar.dart';

typedef IsValidCallback = void Function();
typedef CancelCallback = void Function();

class PasscodeScreen extends StatefulWidget {
  PasscodeScreen({this.status = PasscodeScreenStatus.login});
  final PasscodeScreenStatus status;
  static const route = "/passcode-screen";
  final Stream<bool> shouldTriggerVerification =
      StreamController<bool>.broadcast().stream;

  @override
  State<StatefulWidget> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen>
    with SingleTickerProviderStateMixin {
  final int passwordDigits = 4;
  late PasscodeScreenStatus status;

  // Cancel button and delete button will be switched based on the screen state

  final CircleUIConfig circleUIConfig = CircleUIConfig(circleSize: 30);
  final KeyboardUIConfig keyboardUIConfig =
      KeyboardUIConfig(digitBorderWidth: 1);

  //isValidCallback will be invoked after passcode screen will pop.
  final IsValidCallback? isValidCallback = () {};
  final CancelCallback? cancelCallback = () {
    print("cancel!");
  };

  final Widget? bottomWidget = Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
      child: TextButton(
        child: Text(
          "Reset passcode",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
        ),
        onPressed: () {},
        // splashColor: Colors.white.withOpacity(0.4),
        // highlightColor: Colors.white.withOpacity(0.2),
        // ),
      ),
    ),
  );
  final List<String>? digits = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    "back"
  ];

  late StreamSubscription<bool> streamSubscription;
  String enteredPasscode = '';
  String? prevPasscode;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  initState() {
    status = widget.status;
    super.initState();
    streamSubscription = widget.shouldTriggerVerification
        .listen((isValid) => _showValidation(isValid));
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: ShakeCurve());
    animation = Tween(begin: 0.0, end: 10.0).animate(curve as Animation<double>)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            enteredPasscode = '';
            controller.value = 0;
          });
        }
      })
      ..addListener(() {
        setState(() {
          // the animation object’s value is the changed state
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        showbackButton: widget.status != PasscodeScreenStatus.login,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitPasscodeScreen()
              : _buildLandscapePasscodeScreen();
        },
      ),
    );
  }

  Widget _buildPortraitPasscodeScreen() => SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      status.screenTitle,
                      style: TextStyle(fontSize: 25),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildCircles(),
                      ),
                    ),
                    _buildKeyboard(),
                    bottomWidget ?? Container()
                  ],
                ),
              ),
            ),
            if (widget.status != PasscodeScreenStatus.login)
              Positioned(
                bottom: 20,
                right: 20,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: _buildDeleteButton(),
                ),
              ),
          ],
        ),
      );

  Widget _buildLandscapePasscodeScreen() => Stack(
        children: [
          Positioned(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  status.screenTitle,
                                  style: TextStyle(fontSize: 25),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _buildCircles(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottomWidget != null
                            ? Positioned(
                                child: Align(
                                    alignment: Alignment.topCenter,
                                    child: bottomWidget),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  _buildKeyboard(),
                ],
              ),
            ),
          ),
        ],
      );

  _buildKeyboard() => Container(
        child: Keyboard(
          onKeyboardTap: _onKeyboardButtonPressed,
          keyboardUIConfig: keyboardUIConfig,
          onTapKeyboardBack: _onDeleteCancelButtonPressed,
          onLongPressKeyboardBack: _onDeleteCancelButtonLongPressed,
          digits: digits,
        ),
      );

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = circleUIConfig;
    var extraSize = animation.value;
    for (int i = 0; i < passwordDigits; i++) {
      list.add(
        Container(
          margin: EdgeInsets.all(8),
          child: Circle(
            filled: i < enteredPasscode.length,
            circleUIConfig: config,
            extraSize: extraSize,
          ),
        ),
      );
    }
    return list;
  }

  _onDeleteCancelButtonPressed() {
    if (enteredPasscode.length > 0) {
      setState(() {
        enteredPasscode =
            enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    } else {
      if (cancelCallback != null) {
        cancelCallback!();
      }
    }
  }

  _onDeleteCancelButtonLongPressed() {
    if (enteredPasscode.length > 0) {
      setState(() {
        enteredPasscode = "";
      });
    } else {
      if (cancelCallback != null) {
        cancelCallback!();
      }
    }
  }

  Widget _buildDeleteButton() {
    return Container(
      child: InkWell(
        onTap: () {
          Future.delayed(
              Duration(milliseconds: 100), () => Navigator.pop(context));
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Text(
            'BACK',
            style: const TextStyle(fontSize: 16),
            semanticsLabel: 'BACK',
          ),
        ),
      ),
    );
  }

  _onKeyboardButtonPressed(String text) {
    if (enteredPasscode.length < passwordDigits) {
      setState(() {
        enteredPasscode += text;
        if (status == PasscodeScreenStatus.failure) {
          status = widget.status;
        }
      });
      if (enteredPasscode.length == passwordDigits) {
        //passwordEnteredCallback(enteredPasscode);

        switch (status) {
          case PasscodeScreenStatus.change:
            Get.key!.currentContext!
                .read(GlobalProvider.authProvider.notifier)
                .login(password: enteredPasscode)
                .then((value) => _handleFinal(value));
            break;
          case PasscodeScreenStatus.login:
            Get.key!.currentContext!
                .read(GlobalProvider.authProvider.notifier)
                .login(password: enteredPasscode)
                .then((value) => _handleFinal(value));
            break;
          case PasscodeScreenStatus.setup:
            Future.delayed(
                Duration(milliseconds: 200),
                () => setState(() {
                      status = PasscodeScreenStatus.setupRepeat;
                      prevPasscode = enteredPasscode;
                      enteredPasscode = "";
                    }));
            break;
          case PasscodeScreenStatus.setupRepeat:
            if (enteredPasscode == prevPasscode) {
              print(
                  "is same ${Get.key!.currentContext!.read(GlobalProvider.authProvider).passcode} $enteredPasscode");
              if (widget.status == PasscodeScreenStatus.change &&
                  Get.key!.currentContext!
                      .read(GlobalProvider.authProvider.notifier)
                      .isSamePassword(enteredPasscode)) {
                _handleFinal(false);
                break;
              }
              Get.key!.currentContext!
                  .read(GlobalProvider.authProvider.notifier)
                  .setup(enteredPasscode)
                  .then((value) => _handleFinal(value));
              break;
            }
            _handleFinal(false);

            break;
          case PasscodeScreenStatus.failure:
            break;
          case PasscodeScreenStatus.remove:
            Get.key!.currentContext!
                .read(GlobalProvider.authProvider.notifier)
                .login(password: enteredPasscode)
                .then((value) => _handleFinal(value));
            break;
        }
      }
    }
  }

  _handleFinal(bool value) {
    if (value) {
      if (widget.status == PasscodeScreenStatus.login) {
        Navigator.pushReplacement(
            context,
            CustomPageRoute.verticalTransition(HomePage(),
                animationDuration: Duration(milliseconds: 800)));
      } else if (status == PasscodeScreenStatus.change) {
        setState(() {
          enteredPasscode = '';
          status = PasscodeScreenStatus.setup;
        });
      } else {
        Future.delayed(
            Duration(milliseconds: 300), () => Navigator.pop(context));
      }
    } else {
      if (widget.status == PasscodeScreenStatus.change) {
        ToastHelper.showToast(
            'New passcode must be different with existing passcode');
        Future.delayed(
            Duration(milliseconds: 200),
            () => setState(() {
                  status = PasscodeScreenStatus.setup;
                  enteredPasscode = "";
                }));
      } else {
        ToastHelper.showToast(PasscodeScreenStatus.failure.screenTitle);
        Future.delayed(
            Duration(milliseconds: 200),
            () => setState(() {
                  status = PasscodeScreenStatus.failure;
                  enteredPasscode = "";
                }));
      }
    }
  }

  @override
  didUpdateWidget(PasscodeScreen old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.shouldTriggerVerification != old.shouldTriggerVerification) {
      streamSubscription.cancel();
      streamSubscription = widget.shouldTriggerVerification
          .listen((isValid) => _showValidation(isValid));
    }
  }

  @override
  dispose() {
    controller.dispose();
    streamSubscription.cancel();
    super.dispose();
  }

  _showValidation(bool isValid) {
    if (isValid) {
      Navigator.maybePop(context).then((pop) => _validationCallback());
    } else {
      controller.forward();
    }
  }

  _validationCallback() {
    if (isValidCallback != null) {
      isValidCallback!();
    } else {
      print(
          "You didn't implement validation callback. Please handle a state by yourself then.");
    }
  }
}
