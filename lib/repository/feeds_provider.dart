import 'dart:async';

import 'package:brokali/models/_models.dart' show BroFeedModel, BroUserModel;
import 'package:brokali/utils/_utils.dart' show BroWhereQuery, BroFeedMeta;

import 'base_provider.dart';

/// NEED TO BE REFACTORED!
/// SERVER SIDE MUST HANDLE FEEDS

class BroFeedsProvider extends BroBaseProvider<BroFeedModel> {
  BroFeedsProvider(BroUserModel user) : super(user);

  BroWhereQuery _wq;

  @override
  Future<void> init() async {
    String email = user?.email;

    await initRefs(dbPath: 'feeds');
    _wq = BroWhereQuery('email', isEqualTo: email);
  }

  @override
  Future<Map<String, BroFeedModel>> find([BroWhereQuery wq]) async {
    return formatData(await loadData(_wq + wq), BroFeedModel.fromJSON);
  }

  @override
  Future<BroFeedModel> findById(String id) async {
    return BroFeedModel.fromJSON(await loadDataItem(id));
  }

  @override
  Future<void> add(BroFeedModel feed) async {
    return await addData(feed.data);
  }

  @override
  Future<void> update(BroFeedModel feed) async {
    return await updateData(feed.data);
  }

  @override
  Future<void> delete(BroFeedModel feed) async {
    return await deleteData(feed.data);
  }
}
