import 'package:flutter/material.dart';

class BroLoginFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  BroLoginFlatButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
