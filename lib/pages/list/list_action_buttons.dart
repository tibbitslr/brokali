import 'package:flutter/material.dart';

class BroListActionButtons extends StatelessWidget {
  final VoidCallback onShowInput;
  final VoidCallback onShowProducts;

  BroListActionButtons(this.onShowInput, this.onShowProducts);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Transform.scale(
            scale: 0.8,
            child: FloatingActionButton(
              heroTag: 'ab1',
              backgroundColor: Color(0xFFFFAD4C),
              child: Icon(
                Icons.subject,
                color: Colors.white,
              ),
              onPressed: () => onShowProducts(),
            ),
          ),
        ),
        FloatingActionButton(
          heroTag: 'ab2',
          backgroundColor: Color(0xFF256600),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => onShowInput(),
        ),
      ],
    );
  }
}
