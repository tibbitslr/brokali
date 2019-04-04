import 'package:flutter/material.dart';

import '_models.dart' show BroBaseModel;

class BroFeedModel extends BroBaseModel {
  static const int INVITATION = 1;
  static const int SHARE_STACK = 2;

  final BroFeedMetaModel _meta;

  static BroFeedModel fromJSON(Map data) =>
      data.isNotEmpty ? BroFeedModel(data) : null;

  BroFeedModel(Map data)
      : _meta = BroFeedMetaModel.fromJSON(data['meta'], data['type']),
        super(data);

  int get type => data['type'];
  dynamic get date => data['date'];
  String get message => data['message'];
  String get email => data['email'];

  void markAsRead() => data['read'] = true;
  bool isRead() => data['read'] ?? false;

  BroFeedMetaModel get meta => _meta;
}

abstract class BroFeedMetaModel {
  static BroFeedMetaModel fromJSON(Map meta, int type) {
    if (type == BroFeedModel.INVITATION) {
      return BroFeedMetaModelInvitation(meta);
    } else if (type == BroFeedModel.SHARE_STACK) {
      return BroFeedMetaModelShareStack(meta);
    }
    return null;
  }

  final Map meta;
  BroFeedMetaModel(this.meta);
  Widget toTextWidget();
}

class BroFeedMetaModelInvitation extends BroFeedMetaModel {
  BroFeedMetaModelInvitation(Map meta) : super(meta);

  Widget toTextWidget() {
    return Text('Meta');
  }
}

class BroFeedMetaModelShareStack extends BroFeedMetaModel {
  BroFeedMetaModelShareStack(Map meta) : super(meta);

  String get fromEmail => meta['fromEmail'];
  String get stackId => meta['stackId'];
  String get stackLabel => meta['stackLabel'];

  Widget toTextWidget() {
    return Text(
      'From: $fromEmail \nList: $stackLabel',
      overflow: TextOverflow.visible,
    );
  }
}
