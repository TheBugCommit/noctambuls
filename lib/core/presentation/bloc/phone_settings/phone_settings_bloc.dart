import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/usecases/phone_settings/open_app_settings_usecase.dart';
import 'package:noctambuls/core/domain/usecases/phone_settings/open_phone_location_settings_usecase.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/presentation/bloc/phone_settings/phone_settings_event.dart';
import 'package:noctambuls/core/presentation/bloc/phone_settings/phone_settings_state.dart';

class PhoneSettingsBloc extends Bloc<PhoneSettingsEvent, PhoneSettingsState> {
  PhoneSettingsBloc({
    required this.openAppSettingsUseCase,
    required this.openPhoneLocationSettingsUseCase,
    required this.logger,
  }) : super(const PhoneSettingsInitial()) {
    on<OpenAppSettingsRequested>(_onOpenAppSettingsRequested);
    on<OpenLocationSettingsRequested>(_onOpenLocationSettingsRequested);
  }

  final OpenAppSettingsUseCase openAppSettingsUseCase;
  final OpenPhoneLocationSettingsUseCase openPhoneLocationSettingsUseCase;
  final IAppLogger logger;

  Future<void> _onOpenAppSettingsRequested(
    OpenAppSettingsRequested event,
    Emitter<PhoneSettingsState> emit,
  ) async {
    emit(const PhoneSettingsInitial());
    final result = await openAppSettingsUseCase();

    result.when(
      success: (_) {
        emit(const PhoneSettingsActionSuccess());
      },
      failure: (failure) {
        emit(const PhoneSettingsActionFailure());
        logger.failure(failure);
      },
    );
  }

  Future<void> _onOpenLocationSettingsRequested(
    OpenLocationSettingsRequested event,
    Emitter<PhoneSettingsState> emit,
  ) async {
    emit(const PhoneSettingsInitial());
    final result = await openPhoneLocationSettingsUseCase();

    result.when(
      success: (_) {
        emit(const PhoneSettingsActionSuccess());
      },
      failure: (failure) {
        emit(const PhoneSettingsActionFailure());
        logger.failure(failure);
      },
    );
  }
}
