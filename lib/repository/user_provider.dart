import 'dart:async';

import 'package:brokali/models/_models.dart' show BroUserModel;
import 'package:brokali/utils/_utils.dart' show BroWhereQuery;

import 'base_provider.dart';

/// NEED TO BE REFACTORED!
/// SERVER SIDE MUST HANDLE USERS

class BroUserProvider extends BroBaseProvider<BroUserModel> {
  BroUserProvider(BroUserModel user) : super(user);

  @override
  Future<void> init() async {
    await initRefs(dbPath: 'users');
  }

  BroUserModel getUser() => user;

  @override
  Future<BroUserModel> find([BroWhereQuery wq]) async => getUser();

  @override
  Future<void> update(BroUserModel user) async {
    return await updateData(user.data);
  }
}
