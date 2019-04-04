import 'dart:async';

import 'package:brokali/models/_models.dart' show BroUserModel;
import 'package:brokali/platform/_platform.dart'
    show BroDBFirestore, BroFSCache;
import 'package:brokali/utils/_utils.dart' show BroWhereQuery;

import 'repository.dart';

abstract class BroBaseProvider<Model> {
  final BroRepository repo;

  BroFSCache _fs;
  BroDBFirestore _db;
  BroUserModel _user;

  BroBaseProvider(BroUserModel user)
      : _user = user,
        repo = BroRepository.get();

  Future<void> init();
  Future<dynamic> loadAll() => find();

  Future<dynamic> find([BroWhereQuery wq]) async {}
  Future<dynamic> findById(String id) async {}
  Future<void> add(Model model) async {}
  Future<void> update(Model model) async {}
  Future<void> delete(Model model) async {}

  BroUserModel get user => _user;

  Future<void> initRefs({
    String dbPath,
    String fsCacheName,
    String langCode,
  }) async {
    if (dbPath != null) {
      _db = BroDBFirestore(dbPath);
    }

    if (fsCacheName != null) {
      _fs = BroFSCache();
      await _fs.init(fsCacheName, langCode: langCode);
    }
  }

  Future<Map> loadDataItem(String id) async {
    if (_db != null) return await _db.loadDocument(id);
    if (_fs != null) return await _fs.getCacheDataItem(id);
    return Map();
  }

  Future<List<Map>> loadData([BroWhereQuery wq]) async {
    List<Map> result = List<Map>();

    if (_db != null) result.addAll(await _db.loadDocuments(wq));
    if (_fs != null) result.addAll(await _fs.loadCacheData());

    return result;
  }

  Future<void> addData(Map data) async {
    bool isGuest = await repo.pref.isGuestMode();

    if (_db != null && !isGuest) await _db.createDocument(data);
    if (_fs != null && isGuest) await _fs.addCacheDataItem(data);
  }

  Future<void> updateData(Map data) async {
    bool isGuest = await repo.pref.isGuestMode();

    if (_db != null && !isGuest) await _db.updateDocument(data);
    if (_fs != null && isGuest) await _fs.updateCacheDataItem(data);
  }

  Future<void> deleteData(Map data) async {
    bool isGuest = await repo.pref.isGuestMode();

    if (_db != null && !isGuest) await _db.deleteDocument(data);
    if (_fs != null && isGuest) await _fs.deleteCacheDataItem(data);
  }

  StreamSubscription listenData(Function(List) func, [BroWhereQuery wq]) {
    return _db.listenCollection(func, wq);
  }

  Map<String, Model> formatData<Model>(List data, Function builder) {
    return data.fold(Map(), (acc, it) {
      return acc..addAll({it['_id']: builder(it)});
    });
  }
}
