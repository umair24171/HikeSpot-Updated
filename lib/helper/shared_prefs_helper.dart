import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static Future<dynamic> setData(
      {required String data, required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }


  static Future<String?> getData({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> removeData({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<bool> containsKey({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<Set<String>> getKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }
}
