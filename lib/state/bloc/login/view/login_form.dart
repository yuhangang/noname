import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noname/state/bloc/login/login.dart';

enum InputType { text, password }

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('snack'),
            duration: const Duration(seconds: 1),
            action: SnackBarAction(
              label: 'ACTION',
              onPressed: () {},
            ),
          ));
        }
      },
      child: Stack(
        children: [
          AnimatedPadding(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 150 : 0),
            child: Align(
              alignment: const Alignment(0, 1 / 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _UsernameInput(),
                  const Padding(padding: EdgeInsets.all(12)),
                  _PasswordInput(),
                ],
              ),
            ),
          ),
          BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return state.status.isSubmissionInProgress
                    ? Container(
                        child: Center(
                            child: const CircularProgressIndicator(
                          semanticsLabel: "loading...",
                          semanticsValue: "loading...",
                        )),
                      )
                    : SizedBox();
              })
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPasswordField(
      haveButton: false,
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            style: TextStyle(fontSize: 22.0, color: Colors.black),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle:
                  TextStyle(color: Colors.grey.withOpacity(.9), fontSize: 22),
              hintText: 'username',
              //errorText: state.username.invalid ? 'invalid username' : null,
            ),
          );
        },
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPasswordField(
        haveButton: true,
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (context, state) {
            return TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginBloc>().add(LoginPasswordChanged(password)),
              obscureText: true,
              style: TextStyle(fontSize: 22.0, color: Colors.black),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle:
                    TextStyle(color: Colors.grey.withOpacity(.9), fontSize: 22),
                hintText: 'password',
                //errorText: state.password.invalid ? 'invalid password' : null,
              ),
            );
          },
        ));
  }
}

class LoginPasswordField extends StatelessWidget {
  final bool haveButton;
  final Widget child;

  LoginPasswordField({@required this.child, @required this.haveButton});
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
                    padding: const EdgeInsets.only(top: 3.5), child: child),
              ),
            ),
            if (haveButton)
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return TextButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    child: Container(
                        alignment: FractionalOffset.center,
                        decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0),
                        ),
                        child: Icon(Icons.navigate_next, size: 50)),
                    onPressed: state.status.isValidated
                        ? () {
                            context
                                .read<LoginBloc>()
                                .add(const LoginSubmitted());
                          }
                        : null,
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
