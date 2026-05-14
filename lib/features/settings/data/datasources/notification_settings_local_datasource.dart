import 'package:shared_preferences/shared_preferences.dart';

abstract class NotificationSettingsLocalDataSource {
  bool getNotificationsEnabled();

  Future<void> cacheNotificationsEnabled({required bool isEnabled});
}

class NotificationSettingsLocalDataSourceImpl
    implements NotificationSettingsLocalDataSource {
  NotificationSettingsLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;
  static const String _notificationsKey = 'app_notifications_enabled';

  @override
  bool getNotificationsEnabled() {
    return sharedPreferences.getBool(_notificationsKey) ?? true;
  }

  @override
  Future<void> cacheNotificationsEnabled({required bool isEnabled}) async {
    await sharedPreferences.setBool(_notificationsKey, isEnabled);
  }
}
