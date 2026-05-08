import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/phone_settings_service.dart';

class OpenPhoneLocationSettingsUseCase {
  const OpenPhoneLocationSettingsUseCase(this.service);

  final PhoneSettingsService service;

  Future<Result<Unit>> call() => service.openPhoneLocationSettings();
}
