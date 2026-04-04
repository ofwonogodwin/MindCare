import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesService {
  const AppPreferencesService._();

  static const _firstLaunchKey = 'is_first_launch';
  static const _loggedInKey = 'is_logged_in';
  static const _anonymousModeKey = 'anonymous_mode';
  static const _displayNameKey = 'display_name';

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  static Future<void> setFirstLaunchCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
  }

  static Future<void> saveSession({
    required bool loggedIn,
    required bool anonymousMode,
    String? displayName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, loggedIn);
    await prefs.setBool(_anonymousModeKey, anonymousMode);
    if (displayName != null && displayName.trim().isNotEmpty) {
      await prefs.setString(_displayNameKey, displayName.trim());
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<bool> isAnonymousMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_anonymousModeKey) ?? false;
  }

  static Future<String> getDisplayName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_displayNameKey) ?? 'there';
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
    await prefs.setBool(_anonymousModeKey, false);
    await prefs.remove(_displayNameKey);
  }
}
