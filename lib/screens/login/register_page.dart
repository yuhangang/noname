import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noname/screens/login/login_page.dart';
import 'package:noname/screens/login/widgets/cupertino_radio_choice.dart';
import 'package:noname/screens/login/widgets/login_widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const String route = "/register-page";
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  bool showSpinner = false;
  TextEditingController passwordController = new TextEditingController();
  TextEditingController userEmailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  FocusNode? _focusNode;
  String _passwordhintText = "Password";
  String _userNameHintText = "Your Username";
  String _userEmailHintText = "Your Email";

  static final Map<String, String> genderMap = {
    'student': 'I\'m a Student',
    'alumni': 'I was a Student',
    'Other': 'I am a Visitor',
  };

  String _selectedGender = genderMap.keys.first;
  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Stack(
        children: [
          Container(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Text(
                    "MCONNECT",
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CupertinoRadioChoice(
                        choices: genderMap,
                        onChange: onGenderSelected,
                        initialKeyValue: _selectedGender),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  LoginTextField(
                      focusNode: _focusNode,
                      usernameController: usernameController,
                      userNameHintText: _userNameHintText),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  LoginTextField(
                      focusNode: _focusNode,
                      usernameController: userEmailController,
                      userNameHintText: _userEmailHintText),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  LoginFieldWithButton(
                      focusNode: _focusNode,
                      passwordController: passwordController,
                      passwordhintText: _passwordhintText),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  SwapLoginRegister(
                    route: LoginPage.route,
                    title: "Already Have an Account",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 80,
                  ),
                  SkipLoginButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  var bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 55.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue),
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "loading.. wait...",
                      style: new TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
