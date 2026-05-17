import 'package:noctambuls/features/settings/domain/service/check_notification_permission.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckNotificationPermissionImpl implements CheckNotificationPermission {
  @override
  Future<bool> check() async {
    return (await Permission.notification.status).isGranted;
  }
}
