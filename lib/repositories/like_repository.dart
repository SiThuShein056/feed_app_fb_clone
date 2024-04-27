import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LikeRepository {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences ??= await SharedPreferences.getInstance();
    log("Init method called ${_preferences == null}");
  }

  static SharedPreferences get _pref {
    if (_preferences == null) {
      throw "Please call LileRepository.init() first";
    }

    return _preferences!;
  }

  static Future<bool> action(String key) async {
    log("SEt method called");
    return _preferences!.setBool(key, !get(key));
  }

  static bool get(String key) {
    return _pref.getBool(key) ?? false;
  }
}
