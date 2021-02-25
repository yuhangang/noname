import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noname/screens/home/home_page.dart';
import 'package:noname/state/bloc/login/bloc_login_page.dart';

import 'package:provider/provider.dart';

class LoginFieldWithButton extends StatelessWidget {
  const LoginFieldWithButton({
    Key key,
    @required FocusNode focusNode,
    @required this.passwordController,
    @required String passwordhintText,
  })  : _focusNode = focusNode,
        _passwordhintText = passwordhintText,
        super(key: key);

  final FocusNode _focusNode;
  final TextEditingController passwordController;
  final String _passwordhintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
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
                    focusNode: _focusNode,
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.9), fontSize: 25),
                        hintText: _passwordhintText),
                  ),
                ),
              ),
            ),
            FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: Container(
                  alignment: FractionalOffset.center,
                  decoration: new BoxDecoration(
                    color: Colors.white.withOpacity(0),
                  ),
                  child: Icon(Icons.navigate_next, size: 50)),
              onPressed: () {
                Navigator.pushNamed(context, HomePage.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key key,
    @required FocusNode focusNode,
    @required this.usernameController,
    @required String userNameHintText,
  })  : _focusNode = focusNode,
        _userNameHintText = userNameHintText,
        super(key: key);

  final FocusNode _focusNode;
  final TextEditingController usernameController;
  final String _userNameHintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
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
                    focusNode: _focusNode,
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                    controller: usernameController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.9), fontSize: 25),
                        hintText: _userNameHintText),
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

class SkipLoginButton extends StatelessWidget {
  const SkipLoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        color: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {
          Navigator.pushNamed(context, BlocLoginPage.route);
        },
        child: Text(
          "Continue as Guest",
          style: TextStyle(color: Colors.white, shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(1, 1),
              blurRadius: 5,
            ),
          ]),
        ),
      ),
    );
  }
}

class SwapLoginRegister extends StatelessWidget {
  final String route;
  final String title;

  const SwapLoginRegister({
    @required this.route,
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        color: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, route);
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white, shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(1, 1),
              blurRadius: 5,
            ),
          ]),
        ),
      ),
    );
  }
}
