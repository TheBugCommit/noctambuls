import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:noctambuls/features/settings/domain/service/check_notification_permission.dart';

class CheckNotificationPermissionImpl implements CheckNotificationPermission {
  @override
  Future<bool> check() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();

    return settings.authorizationStatus ==
        AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }
}
