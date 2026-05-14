import 'package:flutter/widgets.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/di/injection_container.dart' as di;
import 'package:noctambuls/core/domain/entities/app_notification.dart';
import 'package:noctambuls/core/domain/usecases/notifications/show_local_notifications_usecase.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/observations/data/datasources/session_local_datasource.dart';
import 'package:noctambuls/features/observations/domain/usecases/sync_pending_sessions_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_notifications_enabled_usecase.dart';
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
        final syncUseCase = di.sl<SyncPendingSessionsUseCase>();
        await syncUseCase();

        final localDataSource = di.sl<SessionLocalDataSource>();
        final unsyncedSessions = await localDataSource.getPendingSessions();

        if (unsyncedSessions.isNotEmpty) {
          final isEnabled = di.sl<GetNotificationsEnabledUseCase>().call();

          if (isEnabled) {
            await di.sl<ShowLocalNotificationUseCase>().call(
              ShowLocalNotificationParams(
                id: 101,
                notification: SyncPendingNotification(unsyncedSessions.length),
              ),
            );
          }
        }
      } finally {
        await dbManager.closeDatabase();
      }
    } catch (_) {
      final isEnabled = di.sl<GetNotificationsEnabledUseCase>().call();

      if (isEnabled) {
        await di.sl<ShowLocalNotificationUseCase>().call(
          const ShowLocalNotificationParams(
            id: 102,
            notification: SyncErrorNotification(),
          ),
        );
      }
    }

    return true;
  });
}
