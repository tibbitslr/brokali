import '_models.dart' show BroBaseModel;

class BroProductModel extends BroBaseModel {
  static BroProductModel fromJSON(Map data) =>
      data.isNotEmpty ? BroProductModel(data) : null;

  BroProductModel(Map data) : super(data);

  String get label => data['label'];
  String get unit => data['unit'];
  List<String> get units => data['units'];
  bool get favorite => data['favorite'];
  bool get sys => data['sys'];
}
