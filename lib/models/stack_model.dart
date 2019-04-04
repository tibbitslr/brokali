import 'package:meta/meta.dart';

import '_models.dart' show BroBaseModel;

class BroStackModel extends BroBaseModel {
  static BroStackModel fromJSON(Map data) =>
      data.isNotEmpty ? BroStackModel(data) : null;

  final List<BroStackListItemModel> _list;

  BroStackModel(Map data)
      : _list = (data['list'] as List)
            .map((it) => BroStackListItemModel(it))
            .toList(),
        super(data);

  String get label => data['label'];
  List get emails => data['emails'];
  List<BroStackListItemModel> get list => _list;
  bool get purchased => _list.length > 0 && _list.every((it) => it.purchased);
}

class BroStackListItemModel extends BroBaseModel {
  BroStackListItemModel(Map data) : super(data);

  String get label => data['label'];
  String get package => data['package'];
  num get qty => data['qty'];

  set purchased(bool value) => data['purchased'] = value;
  bool get purchased => data['purchased'];

  String get productId => data['_product'];
  String get productUnit => data['_unit'];

  factory BroStackListItemModel.build({
    @required String id,
    @required String productId,
    @required String productUnit,
    @required String label,
    @required String package,
    @required num qty,
    @required bool purchased,
  }) {
    return BroStackListItemModel({
      '_id': id,
      '_product': productId,
      '_unit': productUnit,
      'label': label,
      'package': package,
      'qty': qty,
      'purchased': purchased,
    });
  }
}
