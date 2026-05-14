import 'package:noctambuls/features/settings/domain/repositories/notification_settings_repository.dart';

class GetNotificationsEnabledUseCase {
  GetNotificationsEnabledUseCase(this.repository);

  final NotificationSettingsRepository repository;

  bool call() => repository.getNotificationsEnabled();
}
