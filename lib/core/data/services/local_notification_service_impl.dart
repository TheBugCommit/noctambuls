import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:noctambuls/core/domain/entities/app_notification.dart';
import 'package:noctambuls/core/domain/services/notification_service.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_notifications_enabled_usecase.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LocalNotificationServiceImpl implements NotificationService {
  LocalNotificationServiceImpl(
    this._plugin,
    this._saveNotificationsEnabledUseCase,
  );

  final FlutterLocalNotificationsPlugin _plugin;
  final SaveNotificationsEnabledUseCase _saveNotificationsEnabledUseCase;

  @override
  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _plugin.initialize(settings: initSettings);
  }

  @override
  Future<void> showNotification({
    required int id,
    required AppNotification notification,
    String? payload,
  }) async {
    final localeName = Platform.localeName;
    final languageCode = localeName.split('_')[0];
    final supportedLocales = AppLocalizations.supportedLocales.map(
      (l) => l.languageCode,
    );
    final finalLanguage = supportedLocales.contains(languageCode)
        ? languageCode
        : 'ca';

    final l10n = lookupAppLocalizations(Locale(finalLanguage));

    final (
      String title,
      String body,
      String channelId,
      String channelName,
    ) = switch (notification) {
      SyncPendingNotification n => (
        l10n.notificationSyncPendingTitle,
        l10n.notificationSyncPendingBody(n.pendingCount),
        'sync_channel',
        l10n.notificationChannelSyncName,
      ),
      SyncErrorNotification _ => (
        l10n.notificationSyncErrorTitle,
        l10n.notificationSyncErrorBody,
        'sync_channel',
        l10n.notificationChannelSyncName,
      ),
    };

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }

  @override
  Future<void> requestPermissions() async {
    bool? isGranted;

    if (Platform.isIOS) {
      isGranted = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      isGranted = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }

    if (isGranted != null) {
      await _saveNotificationsEnabledUseCase(isEnabled: isGranted);
    }
  }
}
