import 'package:noctambuls/core/data/datasources/notification_local_datasource.dart';
import 'package:noctambuls/core/domain/entities/in_app_notification.dart';
import 'package:noctambuls/core/domain/repositories/in_app_notification_repository.dart';

class InAppNotificationRepositoryImpl implements InAppNotificationRepository {
  const InAppNotificationRepositoryImpl(this._localDataSource);

  final NotificationLocalDataSource _localDataSource;

  @override
  Stream<List<InAppNotification>> watchAll() => _localDataSource.watchAll();

  @override
  Future<void> add(InAppNotification notification) =>
      _localDataSource.add(notification);

  @override
  Future<void> delete(String id) => _localDataSource.delete(id);

  @override
  Future<void> clear() => _localDataSource.clear();
}
