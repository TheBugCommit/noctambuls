import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:noctambuls/core/domain/entities/in_app_notification.dart';
import 'package:noctambuls/core/domain/repositories/in_app_notification_repository.dart';
import 'package:noctambuls/core/domain/services/notification_service.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_notifications_enabled_usecase.dart';

class LocalNotificationServiceImpl implements NotificationService {
  LocalNotificationServiceImpl(
    this._plugin,
    this._saveNotificationsEnabledUseCase,
    this._inboxRepository,
  );

  final FlutterLocalNotificationsPlugin _plugin;
  final SaveNotificationsEnabledUseCase _saveNotificationsEnabledUseCase;
  final InAppNotificationRepository _inboxRepository;

  @override
  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosInit = DarwinInitializationSettings(requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false);
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _plugin.initialize(settings: initSettings);
  }

  @override
  Future<void> showNotification({
    required InAppNotification notification,
    int id = 0,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'noctambuls',
      'Notificacions',
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _plugin.show(
      id: id,
      title: notification.title,
      body: notification.body,
      notificationDetails: const NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: payload,
    );

    await _inboxRepository.add(notification);
  }

  @override
  Future<void> requestPermissions() async {
    final settings = await FirebaseMessaging.instance.requestPermission();
    final isGranted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
    await _saveNotificationsEnabledUseCase(isEnabled: isGranted);
    if (isGranted) {
      // TODO: get apns with apple developer account
      if (Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken == null) {
          return;
        }
      }
      try {
        final fcmToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
      }
    }
  }
}
