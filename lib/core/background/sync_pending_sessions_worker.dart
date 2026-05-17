import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/di/injection_container.dart' as di;
import 'package:noctambuls/core/domain/entities/in_app_notification.dart';
import 'package:noctambuls/core/domain/usecases/notifications/show_local_notifications_usecase.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/observations/data/datasources/session_local_datasource.dart';
import 'package:noctambuls/features/observations/domain/usecases/sync_pending_sessions_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_notifications_enabled_usecase.dart';
import 'package:noctambuls/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

const syncPendingTaskName = 'syncPendingSessionsTask';
const syncPeriodicTaskId = 'sync-pending-sessions';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName != syncPendingTaskName) return true;

    WidgetsFlutterBinding.ensureInitialized();

    try {
      await di.init();

      final secureStorage = di.sl<TokenLocalDataSource>();
      final userId = await secureStorage.getUserId();
      if (userId == null) return true;

      final dbManager = di.sl<UserDatabaseManager>();
      await dbManager.initDatabase(userId);

      try {
        final localDataSource = di.sl<SessionLocalDataSource>();
        final pendingToSync = await localDataSource.getPendingSessions();
        if (pendingToSync.isEmpty) return true;

        final syncUseCase = di.sl<SyncPendingSessionsUseCase>();
        await syncUseCase();

        final unsyncedSessions = await localDataSource.getPendingSessions();

        if (unsyncedSessions.isNotEmpty) {
          final isEnabled = di.sl<GetNotificationsEnabledUseCase>().call();

          if (isEnabled) {
            final l10n = _lookupL10n();
            await di.sl<ShowLocalNotificationUseCase>().call(
              id: 101,
              notification: InAppNotification(
                id: const Uuid().v4(),
                title: l10n.notificationSyncPendingTitle,
                body: l10n.notificationSyncPendingBody(unsyncedSessions.length),
                receivedAt: DateTime.now().toUtc(),
              ),
            );
          }
        }
      } finally {
        await dbManager.closeDatabase();
      }
    } catch (e) {
      final isEnabled = di.sl<GetNotificationsEnabledUseCase>().call();

      if (isEnabled) {
        final l10n = _lookupL10n();
        await di.sl<ShowLocalNotificationUseCase>().call(
          id: 102,
          notification: InAppNotification(
            id: const Uuid().v4(),
            title: l10n.notificationSyncErrorTitle,
            body: l10n.notificationSyncErrorBody,
            receivedAt: DateTime.now().toUtc(),
          ),
        );
      }
    }

    return true;
  });
}

AppLocalizations _lookupL10n() {
  final localeName = Platform.localeName;
  final languageCode = localeName.split('_')[0];
  final supportedLocales = AppLocalizations.supportedLocales.map(
    (l) => l.languageCode,
  );
  final finalLanguage =
      supportedLocales.contains(languageCode) ? languageCode : 'ca';
  return lookupAppLocalizations(Locale(finalLanguage));
}
