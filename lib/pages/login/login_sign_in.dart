import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/login_bloc.dart';
import 'package:brokali/pages/common/_common.dart' show BroTextInputController;

import '_login.dart';

class BroLoginSignIn extends StatefulWidget {
  @override
  State<BroLoginSignIn> createState() => _BroLoginSignInState();
}

class _BroLoginSignInState extends State<BroLoginSignIn> {
  final Color _textColor = Color(0xFFFEF8E5);
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    emailController = BroTextInputController();
    passwordController = BroTextInputController();
  }

  @override
  Widget build(BuildContext context) {
    BroLoginBloc loginBloc = BlocProvider.of<BroLoginBloc>(context);
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        loginBloc.dispatch(BroLoginPreviewEvent());
      },
      child: ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 24.0),
            child: Text(
              'Log In',
              style: TextStyle(
                fontSize: 36,
                color: _textColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          BroLoginInput(
              controller: emailController,
              label: 'Email',
              focusListener: () {
                //
              }),
          BroLoginInput(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 8.0, right: 8.0),
            child: BroLoginFlatButton(
              text: 'Forgot Password?',
              onPressed: () {
                //
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(top: 64.0),
            child: BroLoginRaisedButton(
              text: 'Log In',
              width: size.width - 60,
              onPressed: () {
                loginBloc.dispatch(BroLoginSignInWithEmailEvent(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                ));
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            child: BroLoginFlatButton(
              text: 'Create Account',
              onPressed: () => loginBloc.dispatch(BroLoginSignUpEvent()),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
