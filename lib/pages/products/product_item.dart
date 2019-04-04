import 'package:flutter/material.dart';

import 'package:brokali/models/product_model.dart';

class BroProductItem extends StatelessWidget {
  final BroProductModel model;

  BroProductItem({this.model}) : super(key: ValueKey(model.id));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.label),
    );
  }
}
