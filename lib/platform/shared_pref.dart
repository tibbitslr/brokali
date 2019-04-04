import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class BroSharedPref {
  Future<SharedPreferences> _pref() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> setLangCode(String value) async {
    return (await _pref()).setString('langCode', value);
  }

  Future<String> getLangCode() async {
    return (await _pref()).getString('langCode') ?? 'en';
  }

  Future<void> setGuestMode(bool value) async {
    (await _pref()).setBool('guestMode', value);
  }

  Future<bool> isGuestMode() async {
    return (await _pref()).getBool('guestMode') ?? false;
  }
}
