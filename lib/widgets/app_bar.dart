import 'package:flutter/material.dart';
import 'package:noname/widgets/icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String? title;
  final Function? onBackCalledBack;
  final bool showbackButton;
  final Color? backgroundColor;
  const CustomAppBar(
      {Key? key,
      this.leading,
      this.actions,
      this.title,
      this.onBackCalledBack,
      this.showbackButton = false,
      this.backgroundColor})
      : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: backgroundColor ??
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.97),
      leading: showbackButton
          ? CustomIconButton(
              size: 30,
              onPressed: () {
                if (onBackCalledBack != null) this.onBackCalledBack!();
                Navigator.pop(context);
              },
              icon: Icons.arrow_back_ios,
            )
          : leading,
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
