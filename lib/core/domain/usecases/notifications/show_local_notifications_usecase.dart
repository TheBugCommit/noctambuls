import 'package:noctambuls/core/domain/entities/app_notification.dart';
import 'package:noctambuls/core/domain/services/notification_service.dart';

class ShowLocalNotificationParams {
  const ShowLocalNotificationParams({
    required this.id,
    required this.notification,
    this.payload,
  });

  final int id;
  final AppNotification notification;
  final String? payload;
}

class ShowLocalNotificationUseCase {
  ShowLocalNotificationUseCase(this._service);

  final NotificationService _service;

  Future<void> call(ShowLocalNotificationParams params) async {
    return _service.showNotification(
      id: params.id,
      notification: params.notification,
      payload: params.payload,
    );
  }
}
