import '_models.dart' show BroBaseModel;

class BroSettingsModel extends BroBaseModel {
  static BroSettingsModel fromJSON(Map data) =>
      data.isNotEmpty ? BroSettingsModel(data) : null;

  BroSettingsModel(Map data) : super(data);

  bool get isGuest => data['isGuest'];
}
