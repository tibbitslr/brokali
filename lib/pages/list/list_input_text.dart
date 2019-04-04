import 'list_tags.dart';

enum BroListInputTyping { PRODUCT, QTY, PACKAGE }

class BroListInputText {
  static final String hint = 'Product : Quantity : Package';

  String value;
  String suffix;

  String product;
  String productId;
  String package;
  int qty;

  BroListInputTyping typing;
  bool fromTag = false;

  BroListInputText(String text) {
    fromTag = false;

    value = text;
    package ??= '';
    product ??= '';
    suffix ??= '';

    for (var t in text.split(' ')) {
      var v = int.tryParse(t);

      if (v == null || qty != null) {
        if (qty != null) {
          package += '$t ';
          suffix = '';
          typing = BroListInputTyping.PACKAGE;
        } else {
          product += '$t ';
          suffix = ': Quantity : Package';
          typing = BroListInputTyping.PRODUCT;
        }
      } else {
        qty = v;
        suffix = ': Package';
        typing = BroListInputTyping.QTY;
      }
    }
    product = product.trim();
    package = package.trim();

    if (product.length == 0) {
      product = null;
      suffix = null;
    }

    if (package.length == 0) {
      package = null;
    }

    if (product == null && qty == null && package == null) {
      typing = null;
    }
  }

  void updateValue() {
    value = [product, qty, package].where((a) => a != null).join(' ');
  }

  @override
  String toString() {
    return 'product: $product, package: $package, qty: $qty, value: $value';
  }

  factory BroListInputText.withTag(String text, BroListTag tag) {
    BroListInputText inputText = BroListInputText(text);
    if (tag.postfix == null) inputText.product = tag.text;
    if (tag.postfix != null) inputText.package = tag.text;

    inputText.updateValue();
    inputText.value = inputText.value + (tag.postfix == null ? ' ' : '');
    inputText.productId = tag.id;
    inputText.fromTag = true;

    return inputText;
  }
}
