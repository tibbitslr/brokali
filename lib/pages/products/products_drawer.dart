import 'package:flutter/material.dart';

import 'package:brokali/models/_models.dart' show BroProductModel;
import 'package:brokali/utils/_utils.dart' show BroProductDictionary;

class BroProductsDrawer extends StatelessWidget {
  final BroProductDictionary productDict;
  final Function(BroProductModel model) onSelect;

  BroProductsDrawer(this.productDict, this.onSelect);

  @override
  Widget build(BuildContext context) {
    List<BroProductModel> values = productDict.getAllProducts();
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.only(top: 24.0),
        color: Colors.white,
        width: size.width * 0.7,
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemExtent: 28.0,
          itemCount: values.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(bottom: 6.0),
              child: RaisedButton(
                child: Text(values[index].label),
                onPressed: () {
                  Navigator.of(context).pop();
                  onSelect(values[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
