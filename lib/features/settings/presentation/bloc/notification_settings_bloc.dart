import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/data/services/fcm_service.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/settings/domain/usecases/check_notification_permission_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_notifications_enabled_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_notifications_enabled_usecase.dart';
import 'package:noctambuls/features/settings/presentation/bloc/notification_settings_event.dart';
import 'package:noctambuls/features/settings/presentation/bloc/notification_settings_state.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationSettingsBloc
    extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  NotificationSettingsBloc({
    required this.getEnabledUseCase,
    required this.saveEnabledUseCase,
    required this.checkPermissionUseCase,
    required this.fcmService,
    required this.logger,
  }) : super(NotificationSettingsState(isEnabled: getEnabledUseCase())) {
    on<ToggleNotificationsRequested>(_onToggleNotifications);
    on<NotificationPermissionCheckRequested>(_onCheckPermission);
  }

  final GetNotificationsEnabledUseCase getEnabledUseCase;
  final SaveNotificationsEnabledUseCase saveEnabledUseCase;
  final CheckNotificationPermissionUseCase checkPermissionUseCase;
  final FcmService fcmService;
  final IAppLogger logger;

  Future<void> _onToggleNotifications(
    ToggleNotificationsRequested event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    if (event.isEnabled) {
      final isOsGranted = await checkPermissionUseCase();
      if (!isOsGranted) {
        await openAppSettings();
        return;
      }
    }

    emit(NotificationSettingsState(isEnabled: event.isEnabled));
    final result = await saveEnabledUseCase(isEnabled: event.isEnabled);
    result.when(success: (_) {}, failure: logger.failure);

    if (event.isEnabled) {
      await fcmService.subscribeToNotifications();
    } else {
      await fcmService.unsubscribeFromNotifications();
    }
  }

  Future<void> _onCheckPermission(
    NotificationPermissionCheckRequested event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    final isOsGranted = await checkPermissionUseCase();
    if (!isOsGranted) {
      await saveEnabledUseCase(isEnabled: false);
      emit(const NotificationSettingsState(isEnabled: false));
    } else {
      emit(NotificationSettingsState(isEnabled: getEnabledUseCase()));
    }
  }
}
