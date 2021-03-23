import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noname/commons/constants/theme/custom_themes/customSplashFactory.dart';
import 'package:noname/screens/search_screen/channel_screens.dart';

class SearchScreen extends StatelessWidget {
  static const String route = "/search_screen";
  TextEditingController? _searchController;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 28,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  Expanded(
                      child: CupertinoSearchTextField(
                    itemSize: 25,
                    padding: EdgeInsetsDirectional.fromSTEB(5.8, 10, 5, 10),
                  )),
                ],
              ),
            ),
            Expanded(child: ChannelScreen())
          ],
        ),
      ),
    );
  }
}
