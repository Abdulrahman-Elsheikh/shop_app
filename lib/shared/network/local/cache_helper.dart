// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static var sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putModeBoolean(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool getModeBoolean({
    required String key,
  }) {
    return sharedPreferences.getBool(key);
  }
}
