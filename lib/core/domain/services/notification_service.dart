import 'package:noctambuls/core/domain/entities/app_notification.dart';

abstract interface class NotificationService {
  Future<void> init();

  Future<void> requestPermissions();

  Future<void> showNotification({
    required int id,
    required AppNotification notification,
    String? payload,
  });
}
