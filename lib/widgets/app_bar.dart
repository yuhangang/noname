import 'package:flutter/material.dart';
import 'package:noname/widgets/icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String? title;
  final Function? onBackCalledBack;
  const CustomAppBar(
      {Key? key, this.leading, this.actions, this.title, this.onBackCalledBack})
      : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.97),
      leading: leading,
      //CustomIconButton(
      //  size: 30,
      //  onPressed: () {
      //    if (onBackCalledBack != null) this.onBackCalledBack!();
      //    Navigator.pop(context);
      //  },
      //  icon: Icons.arrow_back_ios,
      //),
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      centerTitle: leading == null ? true : false,
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            )
          : null,
      actions: actions,
    );
  }
}
