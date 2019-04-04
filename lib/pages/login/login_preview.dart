import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/login_bloc.dart';

import '_login.dart';

class BroLoginPreviewPage extends StatelessWidget {
  const BroLoginPreviewPage({Key key}) : super(key: key);

  final Color textColor = const Color(0xFFFEF8E5);

  @override
  Widget build(BuildContext context) {
    BroLoginBloc loginBloc = BlocProvider.of<BroLoginBloc>(context);
    Size size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          left: -68.0,
          bottom: 90.0,
          child: Transform.rotate(
            angle: pi / 1.75,
            child: Image(
              height: 200,
              width: 200,
              image: AssetImage('assets/images/splash3.png'),
            ),
          ),
        ),
        Positioned(
          right: -18.0,
          top: size.height * 0.35,
          child: Transform.rotate(
            angle: pi / 0.1,
            child: Image(
              height: 150,
              width: 150,
              image: AssetImage('assets/images/splash3.png'),
            ),
          ),
        ),
        _Content(size: size, textColor: textColor, loginBloc: loginBloc),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    this.size,
    this.textColor,
    this.loginBloc,
  });

  final Size size;
  final Color textColor;
  final BroLoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.15),
          child: Text(
            'Hello!',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Color(0xFFE6F3C2),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('We\’ve created',
                  style: TextStyle(color: textColor, fontSize: 16)),
              Text(' BroKali',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Text(
            'to help you plan',
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Text(
            'your purchases',
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.40),
          child: BroLoginRaisedButton(
            width: size.width - 60,
            text: 'Sing Up',
            onPressed: () => loginBloc.dispatch(BroLoginSignUpEvent()),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Already have an account?',
                style: TextStyle(color: textColor, fontSize: 14),
              ),
              Container(
                padding: EdgeInsets.only(left: 12.0),
                child: BroLoginFlatButton(
                    text: 'Log In',
                    onPressed: () => loginBloc.dispatch(BroLoginSignInEvent())),
              )
            ],
          ),
        ),
      ],
    );
  }
}
