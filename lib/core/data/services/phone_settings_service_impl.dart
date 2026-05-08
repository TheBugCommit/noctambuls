import 'package:geolocator/geolocator.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/phone_settings_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneSettingsServiceImpl extends PhoneSettingsService {
  @override
  Future<Result<Unit>> openPhoneLocationSettings() async {
    final opened = await Geolocator.openLocationSettings();
    return opened
        ? const Ok(Unit.instance)
        : const Err(
            UnknownFailure(debugMessage: "Can't opent phone location settings"),
          );
  }

  @override
  Future<Result<Unit>> openSettings() async {
    final opened = await openAppSettings();
    return opened
        ? const Ok(Unit.instance)
        : const Err(UnknownFailure(debugMessage: "Can't opent app settings"));
  }
}
