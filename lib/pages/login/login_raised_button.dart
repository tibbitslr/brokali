import 'package:flutter/material.dart';

class BroLoginRaisedButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;

  BroLoginRaisedButton({this.text, this.width, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Color(0xFFFEF8E5),
        disabledColor: Color(0xFFede7d5),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF256600),
            fontSize: 18,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
