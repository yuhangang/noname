import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox(
      {Key key, this.title, this.descriptions, this.text, this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(
                "https://hbr.org/resources/images/article_assets/2019/03/Mar19_19_jason-rosewell-60014-unsplash_3.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 5),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      widget.descriptions,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
