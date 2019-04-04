import 'dart:async';

import 'package:flutter/material.dart';

import 'package:brokali/models/_models.dart' show BroProductModel;
import 'package:brokali/utils/_utils.dart' show BroProductDictionary;

import 'list_input_text.dart';

class BroListTags extends StatelessWidget {
  final StreamController<BroListInputText> strmInputText;
  final BroProductDictionary productDict;

  BroListTags({this.strmInputText, this.productDict})
      : super(key: ValueKey('BroListTags'));

  @override
  Widget build(BuildContext context) {
    String _productId;

    return SingleChildScrollView(
      child: StreamBuilder<Object>(
          stream: strmInputText.stream.asBroadcastStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            List<BroListTag> tags = buildTags(snapshot.data, _productId);

            return Wrap(
              spacing: 12.0,
              runSpacing: 0.0,
              verticalDirection: VerticalDirection.up,
              children: tags.map((tag) {
                return RaisedButton(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  textColor: tag.textColor,
                  color: tag.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Text("${tag.text}${tag.postfix ?? ''}",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                  onPressed: () => selectTag(tag, snapshot.data, _productId),
                );
              }).toList(),
            );
          }),
    );
  }

  List<BroListTag> buildTags(BroListInputText inputText, String _productId) {
    if (inputText.fromTag) return [];

    if (inputText.typing == BroListInputTyping.PRODUCT) {
      _productId = null;

      List<BroProductModel> products =
          productDict.findProductsStartsWithLabel(inputText.product);

      return products.map<BroListTag>((product) {
        return BroListTag(
          id: product.id,
          text: product.label,
          textColor: Colors.white,
          backgroundColor: Colors.green,
        );
      }).toList();
    }

    if (inputText.typing == BroListInputTyping.QTY) {
      if (_productId == null) {
        BroProductModel product =
            productDict.findProductByLabel(inputText.product);
        _productId = product?.id;
      }
    }

    if (inputText.typing == BroListInputTyping.PACKAGE) {
      List<num> packages = inputText.package == null
          ? productDict.getProductPackages(_productId)
          : productDict.findPackagesStartsWith(_productId, inputText.package);

      String unitLabel = productDict.getProductUnitLabel(_productId);

      return packages.map<BroListTag>((package) {
        return BroListTag(
          id: null,
          text: package.toString(),
          textColor: Colors.white,
          backgroundColor: Colors.grey,
          postfix: unitLabel,
        );
      }).toList();
    }

    return [];
  }

  void selectTag(BroListTag tag, BroListInputText inputText, _productId) {
    _productId = tag.id;
    strmInputText.add(BroListInputText.withTag(inputText.value, tag));
  }
}

class BroListTag {
  final String id;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final String postfix;

  BroListTag({
    this.id,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.postfix,
  });
}
