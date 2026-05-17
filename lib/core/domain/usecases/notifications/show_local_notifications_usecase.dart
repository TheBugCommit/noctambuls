import 'package:noctambuls/core/domain/entities/in_app_notification.dart';
import 'package:noctambuls/core/domain/services/notification_service.dart';

class ShowLocalNotificationUseCase {
  ShowLocalNotificationUseCase(this._service);

  final NotificationService _service;

  Future<void> call({required InAppNotification notification, int id = 0}) {
    return _service.showNotification(notification: notification, id: id);
  }
}
