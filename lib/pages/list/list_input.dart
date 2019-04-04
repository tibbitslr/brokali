import 'dart:async';
import 'package:flutter/material.dart';

// import 'package:brokali/models/list_model.dart';
// import 'package:brokali/utils/lists.dart';

import 'package:brokali/pages/common/_common.dart';

import '_list.dart';

class BroListInput extends StatefulWidget {
  final BroTextInputController ctrlInput;
  final StreamController<BroListInputText> strmInputText;
  final Function(BroListInputText inputText) onAddProduct;
  final VoidCallback onHideInput;

  BroListInput({
    this.ctrlInput,
    this.strmInputText,
    this.onAddProduct,
    this.onHideInput,
  });

  @override
  _BroListInputState createState() => _BroListInputState();
}

class _BroListInputState extends State<BroListInput> {
  final FocusNode focusInput = FocusNode();
  String suffix = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextField(
        autofocus: true,
        focusNode: focusInput,
        controller: widget.ctrlInput,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 8.0, bottom: 8.0, left: 2.0, right: 2.0),
          hintText: BroListInputText.hint,
          suffixText: suffix,
        ),
        onChanged: _onInputChange,
        onSubmitted: (String text) async {
          FocusScope.of(context).requestFocus(focusInput);
          await _onSubmit(text);
        },
      ),
    );
  }

  void _onInputChange(String text) {
    widget.ctrlInput.text = text;

    BroListInputText inputText = BroListInputText(text);
    widget.strmInputText.add(inputText);

    setState(() {
      suffix = inputText.suffix;
    });
  }

  Future<void> _onSubmit(String text) async {
    setState(() {
      suffix = '';
    });

    if (text.trim() == '') {
      widget.onHideInput();
    }

    BroListInputText inputText = BroListInputText(text);
    if (inputText.package != null) {
      widget.onAddProduct(inputText);
      widget.ctrlInput.text = '';
    }
  }

  @override
  void dispose() {
    focusInput.dispose();

    super.dispose();
  }
}
