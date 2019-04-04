import 'package:brokali/models/_models.dart' show BroUserModel;
import 'package:brokali/platform/_platform.dart'
    show BroAuthFirebase, BroSharedPref;

import 'base_provider.dart';
import 'categories_provider.dart';
import 'feeds_provider.dart';
import 'products_provider.dart';
import 'stacks_provider.dart';
import 'user_provider.dart';

class BroRepository {
  static final BroRepository _instance = BroRepository();
  static BroRepository get() => _instance;

  BroSharedPref _pref;
  BroAuthFirebase _auth;

  Map<String, BroBaseProvider> _providers;

  Future<void> init() async {
    _pref = BroSharedPref();
    _auth = BroAuthFirebase();

    Map userData = await _auth.getUser();
    BroUserModel user =
        userData != null ? BroUserModel.fromJSON(userData) : null;

    _providers = {
      'products': BroProductsProvider(user),
      'categories': BroCategoriesProvider(user),
      'stacks': BroStacksProvider(user),
      'feeds': BroFeedsProvider(user),
      'user': BroUserProvider(user),
    };

    await Future.forEach(_providers.values, (v) async => await v.init());
  }

  T provider<T extends BroBaseProvider>(String key) => _providers[key];

  BroSharedPref get pref => _pref;
  BroAuthFirebase get auth => _auth;
}
