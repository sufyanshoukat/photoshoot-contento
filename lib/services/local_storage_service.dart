import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _emailKey = 'saved_email';
  static const String _passwordKey = 'saved_password';
  static const String _rememberMeKey = 'remember_me';

  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  static LocalStorageService get instance {
    _instance ??= LocalStorageService._();
    return _instance!;
  }

  LocalStorageService._();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save login credentials
  Future<void> saveLoginCredentials(String email, String password) async {
    await _preferences?.setString(_emailKey, email);
    await _preferences?.setString(_passwordKey, password);
    await _preferences?.setBool(_rememberMeKey, true);
  }

  // Get saved email
  String? getSavedEmail() {
    return _preferences?.getString(_emailKey);
  }

  // Get saved password
  String? getSavedPassword() {
    return _preferences?.getString(_passwordKey);
  }

  // Check if remember me is enabled
  bool isRememberMeEnabled() {
    return _preferences?.getBool(_rememberMeKey) ?? false;
  }

  // Clear saved credentials
  Future<void> clearSavedCredentials() async {
    await _preferences?.remove(_emailKey);
    await _preferences?.remove(_passwordKey);
    await _preferences?.setBool(_rememberMeKey, false);
  }

  // Set remember me preference
  Future<void> setRememberMe(bool value) async {
    await _preferences?.setBool(_rememberMeKey, value);
  }
}
