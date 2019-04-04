import 'package:brokali/models/_models.dart' show BroProductModel;

import 'product_unit.dart';

class BroProductDictionary {
  final Map<String, BroProductModel> _products;

  BroProductDictionary(Map<String, BroProductModel> products)
      : _products = products;

  List<BroProductModel> getAllProducts() {
    return _products.values.toList();
  }

  BroProductModel findProductById(String productId) {
    return _products[productId];
  }

  BroProductModel findProductByLabel(String value) {
    if (value == null) return null;

    return _products.values.firstWhere((product) {
      return product.label.toLowerCase() == value.toLowerCase();
    }, orElse: () => null);
  }

  String getProductUnitLabel(String productId) {
    return BroProductUnit.from(findProductById(productId)?.unit).toString();
  }

  List<num> getProductPackages(String productId) {
    return BroProductUnit.from(findProductById(productId)?.unit).packages;
  }

  List<BroProductModel> findProductsStartsWithLabel(String value) {
    if (value == null) return [];

    return _products.values.fold([], (acc, product) {
      if (product.label != null &&
          product.label.toLowerCase().startsWith(value.toLowerCase())) {
        acc.add(product);
      }

      return acc;
    });
  }

  List<num> findPackagesStartsWith(String productId, String value) {
    if (value == null) return [];

    return getProductPackages(productId).fold([], (acc, package) {
      if (package.toString().startsWith(value.toLowerCase())) {
        acc.add(package);
      }

      return acc;
    });
  }
}
