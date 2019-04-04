import '_models.dart' show BroBaseModel;

class BroUserModel extends BroBaseModel {
  static BroUserModel fromJSON(Map data) =>
      data.isNotEmpty ? BroUserModel(data) : null;

  BroUserModel(Map data) : super(data);

  @override
  String get id => data['uid'];
  String get uid => data['uid'];
  String get email => data['email'];
  String get name => data['name'];
  String get photoUrl => data['photoUrl'];
}
