import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_notifications_enabled_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_notifications_enabled_usecase.dart';
import 'package:noctambuls/features/settings/presentation/bloc/notification_settings_event.dart';
import 'package:noctambuls/features/settings/presentation/bloc/notification_settings_state.dart';

class NotificationSettingsBloc
    extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  NotificationSettingsBloc({
    required this.getEnabledUseCase,
    required this.saveEnabledUseCase,
    required this.logger,
  }) : super(NotificationSettingsState(isEnabled: getEnabledUseCase())) {
    on<ToggleNotificationsRequested>(_onToggleNotifications);
  }

  final GetNotificationsEnabledUseCase getEnabledUseCase;
  final SaveNotificationsEnabledUseCase saveEnabledUseCase;
  final IAppLogger logger;

  Future<void> _onToggleNotifications(
    ToggleNotificationsRequested event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    emit(NotificationSettingsState(isEnabled: event.isEnabled));

    final result = await saveEnabledUseCase(isEnabled: event.isEnabled);
    result.when(
      success: (_) {},
      failure: logger.failure,
    );
  }
}
