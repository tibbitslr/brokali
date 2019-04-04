import 'package:flutter/material.dart';

class BroComingSoonWidget extends StatelessWidget {
  final Widget child;

  BroComingSoonWidget({this.child});

  @override
  Widget build(BuildContext context) {
    Widget comminSoon = Container(
      child: Image(
        image: AssetImage('assets/images/coming_soon.png'),
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          color: Colors.white10,
          child: child,
        ),
        comminSoon,
      ],
    );
  }
}
