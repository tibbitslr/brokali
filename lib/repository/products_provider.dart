import 'dart:async';

import 'package:brokali/models/_models.dart' show BroProductModel, BroUserModel;
import 'package:brokali/utils/_utils.dart' show BroWhereQuery;

import 'base_provider.dart';

class BroProductsProvider extends BroBaseProvider<BroProductModel> {
  BroProductsProvider(BroUserModel user) : super(user);

  @override
  Future<void> init() async {
    String uid = user?.uid;

    await initRefs(
      dbPath: uid != null ? 'users/$uid/products' : null,
      fsCacheName: 'products',
      langCode: await repo.pref.getLangCode(),
    );
  }

  @override
  Future<Map<String, BroProductModel>> find([BroWhereQuery wq]) async {
    return formatData(await loadData(wq), BroProductModel.fromJSON);
  }

  @override
  Future<BroProductModel> findById(String id) async {
    return BroProductModel.fromJSON(await loadDataItem(id));
  }

  @override
  Future<void> add(BroProductModel product) async {
    return await addData(product.data);
  }

  @override
  Future<void> update(BroProductModel product) async {
    return await updateData(product.data);
  }

  @override
  Future<void> delete(BroProductModel product) async {
    return await deleteData(product.data);
  }
}
