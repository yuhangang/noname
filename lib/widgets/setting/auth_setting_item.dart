import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonote/navigation/custom_page_route/custom_page_route.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/views/login/passcode_screen/passcode_screen.dart';
import 'package:todonote/widgets/expandable.dart';
import 'package:todonote/widgets/setting/button_setting_item.dart';
import 'package:todonote/widgets/setting/switch_button_item.dart';

class AuthSettingItem extends ConsumerWidget {
  AuthSettingItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  final ExpandableController _expandableController =
      new ExpandableController(initialExpanded: true);
  @override
  Widget build(BuildContext context, watch) {
    Auth auth = watch(GlobalProvider.authProvider);
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          SwitchButtonItem(
            title: "enhance security",
            value: auth.isRequiredAuthentication,
            onchange: (e) {
              if (auth.isRequiredAuthentication) {
                Navigator.push(
                    context,
                    CustomPageRoute.verticalTransition(PasscodeScreen(
                      status: PasscodeScreenStatus.remove,
                    )));
              } else {
                Navigator.push(
                    context,
                    CustomPageRoute.verticalTransition(PasscodeScreen(
                      status: PasscodeScreenStatus.setup,
                    )));
              }
            },
          ),
          Expandable(
              controller: ExpandableController(
                  initialExpanded: auth.isRequiredAuthentication),
              collapsed: Container(),
              expanded: Column(
                children: [
                  ButtonSettingItem(
                    title: "Change Passcode",
                    icon: Icon(Icons.security_outlined),
                    onTapItem: () {
                      Navigator.push(
                          context,
                          CustomPageRoute.verticalTransition(PasscodeScreen(
                            status: PasscodeScreenStatus.change,
                          )));
                    },
                  ),
                  SwitchButtonItem(
                    title: "use biometric authentication",
                    value: true,
                    onchange: (e) {},
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

enum AuthSettingItemState { disabled, enabled }
