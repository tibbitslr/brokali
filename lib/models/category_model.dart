import '_models.dart' show BroBaseModel;

class BroCategoryModel extends BroBaseModel {
  static BroCategoryModel fromJSON(Map data) =>
      data.isNotEmpty ? BroCategoryModel(data) : null;

  BroCategoryModel(Map data) : super(data);

  String get label => data['label'];
  String get color => data['color'];
  bool get sys => data['sys'];
}
