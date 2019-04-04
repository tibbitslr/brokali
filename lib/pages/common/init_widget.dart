import 'package:flutter/material.dart';

class BroInitWidget extends StatelessWidget {
  final Widget child;
  BroInitWidget({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Container(
          alignment: AlignmentDirectional(0.0, 0.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [-0.22, 1],
              colors: [
                Color(0xFF8FC72E),
                Color(0xFF256600),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
