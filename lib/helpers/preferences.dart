import 'package:shared_preferences/shared_preferences.dart';

enum PreferencesKey { locale, theme }

class Preferences {
  static late final SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String? getString(PreferencesKey key) =>
      _preferences.getString(key.name);

  static Future<bool> setString(PreferencesKey key, String value) =>
      _preferences.setString(key.name, value);
}
