import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:brokali/utils/_utils.dart' show BroWhereQuery;

class BroDBFirestore {
  final CollectionReference _ref;

  BroDBFirestore(String path) : _ref = Firestore.instance.collection('$path');

  dynamic db([BroWhereQuery wq]) {
    if (wq == null) return _ref;

    return _ref.where(
      wq.field,
      isEqualTo: wq.isEqualTo,
      isLessThan: wq.isLessThan,
      isLessThanOrEqualTo: wq.isLessThanOrEqualTo,
      isGreaterThan: wq.isGreaterThan,
      isGreaterThanOrEqualTo: wq.isGreaterThanOrEqualTo,
      arrayContains: wq.arrayContains,
      isNull: wq.isNull,
    );
  }

  Future<List<Map>> loadDocuments([BroWhereQuery wq]) async {
    try {
      var ee = fromQuerySnapshot(await db(wq).getDocuments());
      return fromQuerySnapshot(await db(wq).getDocuments());
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Map> loadDocument(String id) async {
    try {
      return fromDocumentSnapshot(await db().document(id).get());
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> createDocument(Map data, [String id]) async {
    try {
      await db().document(id).setData(Map<String, dynamic>.from(data));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateDocument(Map data) async {
    try {
      await db()
          .document(data['_id'])
          .updateData(Map<String, dynamic>.from(data));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteDocument(Map data) async {
    try {
      await db().document(data['_id']).delete();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StreamSubscription listenCollection(Function(List) func, [BroWhereQuery wq]) {
    try {
      return db(wq)
          .snapshots()
          .listen((snapshot) => func(fromQuerySnapshot(snapshot)));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StreamSubscription listenDocument(
    String id,
    Function(Map) func,
  ) {
    try {
      return db()
          .document(id)
          .snapshots()
          .listen((snapshot) => func(fromDocumentSnapshot(snapshot)));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  List<Map> fromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.fold([], (acc, doc) {
      return acc..add(doc.data..['_id'] = doc.documentID);
    });
  }

  Map fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return snapshot.data..['_id'] = snapshot.documentID;
  }
}
