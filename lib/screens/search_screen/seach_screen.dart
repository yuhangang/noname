import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const String route = "/search_screen";
  TextEditingController _searchController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [SearchTextField(searchController: _searchController)],
          ),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key key, @required this.searchController})
      : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.only(left: 35),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(75), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 7,
              child: Container(
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.5),
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    controller: searchController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.9), fontSize: 20),
                        hintText: "search"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
