import 'package:noctambuls/core/domain/entities/in_app_notification.dart';

abstract interface class NotificationService {
  Future<void> init();

  Future<void> requestPermissions();

  Future<void> showNotification({
    required InAppNotification notification,
    int id = 0,
    String? payload,
  });
}
