import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorgeServices {
  static late SharedPreferences _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  static Future<bool> setBpol(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  static Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return _preferences.setStringList(key, value);
  }

 static int? getInt(String key) {
    return _preferences.getInt(key);
  }
  
 static bool? getBool(String key) {
    return _preferences.getBool(key);
  }
  
 static String? getString(String key) {
    return _preferences.getString(key);
  }
  
 static List<String>? getListString(String key) {
    return _preferences.getStringList(key);
  }
  

}
