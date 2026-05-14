import 'package:noctambuls/core/domain/error/result.dart';

abstract class NotificationSettingsRepository {
  bool getNotificationsEnabled();

  Future<Result<Unit>> saveNotificationsEnabled({required bool isEnabled});
}
