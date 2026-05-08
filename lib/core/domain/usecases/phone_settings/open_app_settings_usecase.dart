import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/phone_settings_service.dart';

class OpenAppSettingsUseCase {
  const OpenAppSettingsUseCase(this.service);

  final PhoneSettingsService service;

  Future<Result<Unit>> call() => service.openSettings();
}
