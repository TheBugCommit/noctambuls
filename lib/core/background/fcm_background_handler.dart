import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:noctambuls/core/data/services/fcm_service.dart';
import 'package:noctambuls/core/di/injection_container.dart' as di;
import 'package:noctambuls/core/domain/repositories/in_app_notification_repository.dart';
import 'package:noctambuls/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await di.init();
    final inboxRepository = di.sl<InAppNotificationRepository>();
    await inboxRepository.add(message.toInAppNotification());
  } catch (_) {}
}
