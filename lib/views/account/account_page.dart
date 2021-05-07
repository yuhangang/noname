import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/views/home/home_page.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/providers/local/edit_todo/edit_todo_provider.dart';
import 'package:todonote/widgets/setting/auth_setting_item.dart';
import 'package:todonote/widgets/setting/button_setting_item.dart';
import 'package:todonote/widgets/setting/switch_button_item.dart';

class AccountPage extends StatelessWidget {
  static const route = "/account-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePage.homePageAppbar(context, title: 'Settings'),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Consumer(
              builder: (_, watch, child) {
                return SwitchButtonItem(
                  value: watch(GlobalProvider.themeProvider).isDarkMode,
                  title: "dark mode",
                  onchange: (bool val) {
                    context
                        .read(GlobalProvider.themeProvider.notifier)
                        .switchDarkLightMode(val);
                  },
                );
              },
            ),
            //const Divider(),
            //SwitchButtonItem(
            //  title: "Time Mode",
            //  value: true,
            //),
            const Divider(),
            AuthSettingItem(title: "Authentication"),
            const Divider(),
            Consumer(
              builder: (context, watch, child) {
                Auth auth = watch(GlobalProvider.authProvider);
                return auth.isRequiredAuthentication
                    ? ButtonSettingItem(
                        title: 'Sign Out',
                        icon: Icon(Icons.logout),
                        onTapItem: () {
                          context
                              .read(GlobalProvider.authProvider.notifier)
                              .signOut();
                        },
                      )
                    : SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
