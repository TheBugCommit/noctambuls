import 'package:noctambuls/core/domain/error/result.dart';

abstract class PhoneSettingsService {
  Future<Result<Unit>> openPhoneLocationSettings();

  Future<Result<Unit>> openSettings();
}
