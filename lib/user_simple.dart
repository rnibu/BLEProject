

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences{
  static late SharedPreferences _preferences;
  static const _keyUsername = 'username';
  static const _keyPassword = 'password';
  static const _keyRemember = 'false';

  static Future init() async =>
  _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);
  static String? getUsername() => _preferences.getString(_keyUsername);

  static Future setPassword(String password) async =>
      await _preferences.setString(_keyPassword, password);
  static String? getPassword() => _preferences.getString(_keyPassword);

  static Future setRememberMe(bool remember) async =>
      await _preferences.setBool(_keyRemember, remember);
  static bool? getRememberMe() => _preferences.getBool(_keyRemember);
}