import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:noctambuls/core/domain/entities/in_app_notification.dart';
import 'package:noctambuls/core/domain/repositories/in_app_notification_repository.dart';
import 'package:noctambuls/core/domain/services/notification_service.dart';
import 'package:uuid/uuid.dart';

class FcmService {
  FcmService(this._notificationService, this._inboxRepository);

  final NotificationService _notificationService;
  final InAppNotificationRepository _inboxRepository;

  Future<void> init({required bool notificationsEnabled}) async {
    try {
      if (notificationsEnabled) {
        await subscribeToNotifications();
      }
      final initial = await FirebaseMessaging.instance
          .getInitialMessage()
          .timeout(const Duration(seconds: 3));
      if (initial != null) {
        await _inboxRepository.add(initial.toInAppNotification());
      }
    } catch (e) {}

    FirebaseMessaging.onMessage.listen(_onForeground);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpened);
  }

  Future<void> subscribeToNotifications() => FirebaseMessaging.instance
      .subscribeToTopic('censuses')
      .timeout(const Duration(seconds: 15));

  Future<void> unsubscribeFromNotifications() => FirebaseMessaging.instance
      .unsubscribeFromTopic('censuses')
      .timeout(const Duration(seconds: 15));

  Future<void> _onForeground(RemoteMessage message) async {
    await _notificationService.showNotification(
      notification: message.toInAppNotification(),
      id: message.hashCode,
    );
  }

  Future<void> _onOpened(RemoteMessage message) async {
    await _inboxRepository.add(message.toInAppNotification());
  }
}

extension RemoteMessageMapper on RemoteMessage {
  InAppNotification toInAppNotification() {
    return InAppNotification(
      id: messageId ?? const Uuid().v4(),
      title: notification?.title ?? '',
      body: notification?.body ?? '',
      receivedAt: DateTime.now().toUtc(),
    );
  }
}
