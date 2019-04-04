import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BroServices {
  static setStatusBarColor(int value) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Color(value),
    // ));
  }

  static hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
