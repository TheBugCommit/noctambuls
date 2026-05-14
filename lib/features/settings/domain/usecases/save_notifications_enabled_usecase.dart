import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/settings/domain/repositories/notification_settings_repository.dart';

class SaveNotificationsEnabledUseCase {
  SaveNotificationsEnabledUseCase(this.repository);

  final NotificationSettingsRepository repository;

  Future<Result<Unit>> call({required bool isEnabled}) =>
      repository.saveNotificationsEnabled(isEnabled: isEnabled);
}
