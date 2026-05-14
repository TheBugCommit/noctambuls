import 'package:noctambuls/core/domain/entities/app_notification.dart';

abstract class NotificationService {
  Future<void> init();

  Future<void> showNotification({
    required int id,
    required AppNotification notification,
    String? payload,
  });
}
