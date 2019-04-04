import 'package:flutter/material.dart';

class BroLoginInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final VoidCallback focusListener;

  BroLoginInput({
    this.controller,
    this.label,
    this.obscureText = false,
    this.focusListener,
  });

  @override
  _BroLoginInputState createState() => _BroLoginInputState();
}

class _BroLoginInputState extends State<BroLoginInput> {
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    if (widget.focusListener != null) {
      focusNode.addListener(widget.focusListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.0,
        top: 24.0,
        right: 24.0,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          hintColor: Color(0xFFFEF8E5),
        ),
        child: TextField(
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: Color(0xFFFEF8E5),
              fontSize: 16,
            ),
            labelText: widget.label,
            fillColor: Colors.black,
          ),
          focusNode: focusNode,
          controller: widget.controller,
          obscureText: widget.obscureText,
        ),
      ),
    );
  }
}
