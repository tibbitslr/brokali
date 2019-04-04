import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/login_bloc.dart';
import 'package:brokali/pages/common/_common.dart' show BroComingSoonWidget;

import '_login.dart';

class BroLoginSignUp extends StatefulWidget {
  @override
  State<BroLoginSignUp> createState() => _BroLoginSignUpState();
}

class _BroLoginSignUpState extends State<BroLoginSignUp> {
  final Color _textColor = Color(0xFFFEF8E5);
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  bool isKeyboardOpen;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    isKeyboardOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    BroLoginBloc loginBloc = BlocProvider.of<BroLoginBloc>(context);
    Size size = MediaQuery.of(context).size;

    Widget content = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 24.0),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 36,
              color: _textColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        BroLoginInput(
          controller: _nameController,
          label: 'Name',
          focusListener: () {
            setState(() {
              isKeyboardOpen = true;
            });
          },
        ),
        BroLoginInput(
          controller: _emailController,
          label: 'Email',
        ),
        BroLoginInput(
          controller: _passwordController,
          label: 'Password',
          obscureText: true,
        ),
        Container(
          padding: EdgeInsets.only(top: 64.0),
          child: BroLoginRaisedButton(
            text: 'Sign Up',
            width: size.width - 60,
            onPressed: () {
              //TODO validate
              loginBloc.dispatch(BroLoginSignUpWithEmailEvent(
                _nameController.text,
                _emailController.text,
                _passwordController.text,
              ));
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Already have an account?',
                style: TextStyle(color: _textColor, fontSize: 14),
              ),
              Container(
                padding: EdgeInsets.only(left: 12.0),
                child: BroLoginFlatButton(
                  text: 'Log In',
                  onPressed: () => loginBloc.dispatch(BroLoginSignInEvent()),
                ),
              )
            ],
          ),
        ),
      ],
    );

    Widget term = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By creating account you agree\n',
          style: TextStyle(color: _textColor),
          children: <TextSpan>[
            TextSpan(
              text: 'to the ',
              style: TextStyle(color: _textColor),
            ),
            TextSpan(
              text: 'Terms of Service ',
              style: TextStyle(height: 1.3, color: Color(0xFFD1FF82)),
            ),
            TextSpan(
              text: 'and ',
              style: TextStyle(height: 1.3, color: _textColor),
            ),
            TextSpan(
              text: 'Privacy Policy ',
              style: TextStyle(height: 1.3, color: Color(0xFFD1FF82)),
            ),
          ],
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () {
        loginBloc.dispatch(BroLoginPreviewEvent());
      },
      child: BroComingSoonWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height - 80,
                child: content,
              ),
              term
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
