abstract class BroBaseModel {
  final Map data;

  BroBaseModel(this.data);

  String get id => data['_id'];
}
