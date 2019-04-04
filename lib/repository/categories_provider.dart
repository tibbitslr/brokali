import 'dart:async';

import 'package:brokali/models/_models.dart'
    show BroCategoryModel, BroUserModel;
import 'package:brokali/utils/_utils.dart' show BroWhereQuery;

import 'base_provider.dart';

class BroCategoriesProvider extends BroBaseProvider<BroCategoryModel> {
  BroCategoriesProvider(BroUserModel user) : super(user);

  @override
  Future<void> init() async {
    String uid = user?.uid;

    await initRefs(
      dbPath: uid != null ? 'users/$uid/categories' : null,
      fsCacheName: 'categories',
      langCode: await repo.pref.getLangCode(),
    );
  }

  @override
  Future<Map<String, BroCategoryModel>> find([BroWhereQuery wq]) async {
    return formatData(await loadData(wq), BroCategoryModel.fromJSON);
  }

  @override
  Future<BroCategoryModel> findById(String id) async {
    return BroCategoryModel.fromJSON(await loadDataItem(id));
  }

  @override
  Future<void> add(BroCategoryModel model) async {
    return await addData(model.data);
  }

  @override
  Future<void> update(BroCategoryModel category) async {
    return await updateData(category.data);
  }

  @override
  Future<void> delete(BroCategoryModel category) async {
    return await deleteData(category.data);
  }
}
