import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/screens/home/home_page.dart';
import 'package:noname/state/providers/global/globalProvider.dart';

class AccountPage extends StatelessWidget {
  static const route = "/account-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePage.homePageAppbar(context, title: 'Account'),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Consumer(
              builder: (_, watch, child) {
                return SwitchButtonItem(
                  value: watch(GlobalProvider.themeProvider.state).isDarkMode,
                  title: "dark mode",
                  onchange: (bool val) {
                    context
                        .read(GlobalProvider.themeProvider)
                        .switchDarkLightMode(val);
                  },
                );
              },
            ),
            const Divider(),
            SwitchButtonItem(
              value: true,
              disabled: true,
            ),
            ButtonSettingItem(
              title: 'Sign Out',
              icon: Icon(Icons.logout),
              onTapItem: () {
                context.read(GlobalProvider.authProvider).signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}

class ButtonSettingItem extends StatelessWidget {
  const ButtonSettingItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTapItem,
  }) : super(key: key);
  final void Function() onTapItem;
  final Icon icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(title))),
            const SizedBox(
              width: 10,
            ),
            InkWell(
                onTap: onTapItem,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon,
                )),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  MyClipper({required this.sizeRate, required this.offset});
  final double sizeRate;
  final Offset offset;

  @override
  Path getClip(Size size) {
    var path = Path()
      ..addOval(
        Rect.fromCircle(center: offset, radius: size.height * sizeRate),
      );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class SwitchButtonItem extends StatelessWidget {
  void Function(bool)? onchange;
  bool disabled;
  bool value;
  final String title;
  TextStyle? titleStyle;
  SwitchButtonItem(
      {Key? key,
      required this.value,
      this.disabled = false,
      this.title = "NaN",
      this.onchange,
      this.titleStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !disabled
        ? buildSwitch(context)
        : IgnorePointer(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).accentColor.withOpacity(0.2),
                  BlendMode.xor),
              child: buildSwitch(context),
            ),
          );
  }

  Widget buildSwitch(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      title,
                      style: titleStyle,
                    ))),
            const SizedBox(
              width: 10,
            ),
            Switch(
              value: this.value,
              onChanged: this.onchange ?? (bool val) {},
              activeColor: Theme.of(context).canvasColor,
            ),
          ],
        ),
      ),
    );
  }
}
