import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class BroFSCache {
  static Future<String> get localPath async {
    return (await getApplicationDocumentsDirectory()).path;
  }

  final List<Map> _cache;
  File _cacheFile;

  BroFSCache() : _cache = List<Map>();

  Future<void> init(String name, {String langCode}) async {
    try {
      if (langCode != null) {
        String strData = await rootBundle.loadString('assets/data/$name.json');
        List data = json.decode(strData);

        String strLangData =
            await rootBundle.loadString('assets/i18n/$name/$langCode.json');
        Map langData = json.decode(strLangData);

        _cache.addAll(data.map((it) {
          it['label'] = langData[it['_id']];
          it['sys'] = true;
          return it;
        }));
      }

      String localPath = await BroFSCache.localPath;
      _cacheFile = File('$localPath/cache_$name.json');
      await _writeCacheDataFile(json.encode([]));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<List<Map>> loadCacheData() async {
    return _cache
      ..addAll(List<Map>.from(
        json.decode(await _readCacheDataFile()),
      ));
  }

  Future<Map> getCacheDataItem(String id) async {
    //  TODO
    return Map();
  }

  Future<void> addCacheDataItem(Map item) async {
    item['_id'] = DateTime.now().millisecondsSinceEpoch.toString();

    List<Map> data = await loadCacheData();
    data.add(item);

    await _writeCacheDataFile(json.encode(data));
  }

  Future<void> updateCacheDataItem(Map item) async {
    if (item['sys'] == null) {
      List<Map> data = (await loadCacheData()).map((it) {
        return it['_id'] == item['_id'] ? item : it;
      });

      await _writeCacheDataFile(json.encode(data));
    }
  }

  Future<void> deleteCacheDataItem(Map item) async {
    if (item['sys'] == null) {
      List<Map> data = await loadCacheData();
      data.removeWhere((it) => it['_id'] == item['_id']);

      await _writeCacheDataFile(json.encode(data));
    }
  }

  void clearNonSystemCacheData() {
    //
  }

  Future<String> _readCacheDataFile() async {
    try {
      return await _cacheFile.readAsString();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> _writeCacheDataFile(String txt) async {
    try {
      await _cacheFile.writeAsString(txt);
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
