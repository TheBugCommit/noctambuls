import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/settings/data/datasources/notification_settings_local_datasource.dart';
import 'package:noctambuls/features/settings/domain/repositories/notification_settings_repository.dart';

class NotificationSettingsRepositoryImpl
    implements NotificationSettingsRepository {
  NotificationSettingsRepositoryImpl({required this.localDataSource});

  final NotificationSettingsLocalDataSource localDataSource;

  @override
  bool getNotificationsEnabled() {
    return localDataSource.getNotificationsEnabled();
  }

  @override
  Future<Result<Unit>> saveNotificationsEnabled({
    required bool isEnabled,
  }) async {
    try {
      await localDataSource.cacheNotificationsEnabled(isEnabled: isEnabled);
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const CacheFailure().withDebug(e, st));
    }
  }
}
