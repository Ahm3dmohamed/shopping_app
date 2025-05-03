import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setValue<T>(String key, T value) async {
    if (value is String) return _prefs.setString(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    if (value is bool) return _prefs.setBool(key, value);
    if (value is List<String>) return _prefs.setStringList(key, value);
    throw Exception("Unsupported type");
  }

  static T? getValue<T>(String key) {
    final value = _prefs.get(key);
    if (value is T) return value;
    return null;
  }

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  static Future<bool> clear() async {
    return await _prefs.clear();
  }

  static bool contains(String key) {
    return _prefs.containsKey(key);
  }
}
