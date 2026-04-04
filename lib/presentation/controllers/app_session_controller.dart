import '../../services/app_preferences_service.dart';

class AppSessionController {
  const AppSessionController._();

  static Future<bool> shouldShowWelcome() async {
    return AppPreferencesService.isFirstLaunch();
  }

  static Future<void> completeWelcome() async {
    await AppPreferencesService.setFirstLaunchCompleted();
  }

  static Future<void> login({
    required bool anonymousMode,
    required String displayName,
  }) async {
    await AppPreferencesService.saveSession(
      loggedIn: true,
      anonymousMode: anonymousMode,
      displayName: displayName,
    );
  }

  static Future<void> logout() async {
    await AppPreferencesService.clearSession();
  }

  static Future<bool> isLoggedIn() async {
    return AppPreferencesService.isLoggedIn();
  }

  static Future<bool> isAnonymous() async {
    return AppPreferencesService.isAnonymousMode();
  }

  static Future<String> displayName() async {
    return AppPreferencesService.getDisplayName();
  }
}
