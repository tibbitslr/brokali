import 'dart:async';

import 'package:brokali/models/_models.dart' show BroStackModel, BroUserModel;
import 'package:brokali/utils/_utils.dart' show BroWhereQuery;

import 'base_provider.dart';

class BroStacksProvider extends BroBaseProvider<BroStackModel> {
  BroStacksProvider(BroUserModel user) : super(user);

  BroWhereQuery _wq;

  @override
  Future<void> init() async {
    String email = user?.email;

    await initRefs(dbPath: 'stacks', fsCacheName: 'stacks');
    _wq = BroWhereQuery('emails', arrayContains: email);
  }

  @override
  Future<Map<String, BroStackModel>> find([BroWhereQuery wq]) async {
    var wee = await loadData(_wq + wq);
    return formatData(await loadData(_wq + wq), BroStackModel.fromJSON);
  }

  @override
  Future<BroStackModel> findById(String id) async {
    return BroStackModel.fromJSON(await loadDataItem(id));
  }

  @override
  Future<void> add(BroStackModel stack) async {
    return await addData(stack.data);
  }

  @override
  Future<void> update(BroStackModel stack) async {
    return await updateData(stack.data);
  }

  @override
  Future<void> delete(BroStackModel stack) async {
    return await deleteData(stack.data);
  }
}
