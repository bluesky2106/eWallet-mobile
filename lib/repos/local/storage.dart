import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  // singleton
  static final Storage _singleton =  new Storage._internal();
  SharedPreferences _prefs;

  Storage._internal();

  factory Storage() {
    return _singleton;
  }

  Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  void saveBoolean(String key, bool value) {
    _prefs.setBool(key, value);
  }

  bool getBoolean(String key) {
    return _prefs.getBool(key) ?? false;
  }

  void saveString(String key, String value) {
    _prefs.setString(key, value);
  }

  String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  void saveInt(String key, int value) {
    _prefs.setInt(key, value);
  }

  int getInt(String key) {
    return _prefs.getInt(key) ?? -1;
  }

  void saveDouble(String key, double value) {
    _prefs.setDouble(key, value);
  }

  double getDouble(String key) {
    return _prefs.getDouble(key) ?? 0;
  }

  void remove(String key) {
    _prefs.remove(key);
  }
}