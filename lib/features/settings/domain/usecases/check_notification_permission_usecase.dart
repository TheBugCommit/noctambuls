import 'package:noctambuls/features/settings/domain/service/check_notification_permission.dart';

class CheckNotificationPermissionUseCase {
  const CheckNotificationPermissionUseCase(this.service);

  final CheckNotificationPermission service;

  Future<bool> call() async => service.check();
}
