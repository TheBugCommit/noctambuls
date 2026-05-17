import 'package:noctambuls/core/domain/entities/in_app_notification.dart';

abstract interface class InAppNotificationRepository {
  Stream<List<InAppNotification>> watchAll();

  Future<void> add(InAppNotification notification);

  Future<void> delete(String id);

  Future<void> clear();
}
