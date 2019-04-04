import 'package:flutter/material.dart';

class BroTextInputController extends TextEditingController {
  BroTextInputController({String text}) : super(text: text);

  set text(String text) {
    value = value.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
      composing: TextRange.empty,
    );
  }
}
