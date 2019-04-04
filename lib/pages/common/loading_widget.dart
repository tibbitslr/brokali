import 'package:flutter/material.dart';

import '_common.dart' show BroLoadingIndicator;

class BroLoadingWidget extends StatelessWidget {
  final Widget child;
  final bool loading;
  final bool isEmpty;

  BroLoadingWidget({this.child, this.loading, this.isEmpty = false});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [child];

    if (loading) {
      children.add(BroLoadingIndicator());
    } else if (isEmpty) {
      children.add(Center(
        child: Text(
          'No Data',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ));
    }

    return Stack(
      fit: StackFit.expand,
      children: children,
    );
  }
}
