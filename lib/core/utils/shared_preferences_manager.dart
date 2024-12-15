import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
    return _instance;
  }

  SharedPreferencesManager._internal();

  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a string value
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Get a string value
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Remove a key
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all preferences
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
