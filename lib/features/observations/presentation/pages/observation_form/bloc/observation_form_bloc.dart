import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/save_observation_usecase.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_state.dart';

class ObservationFormBloc
    extends Bloc<ObservationFormEvent, ObservationFormState> {
  ObservationFormBloc({
    required this.getBirdsUseCase,
    required this.saveObservationUseCase,
    required this.logger,
  }) : super(const ObservationFormInitial()) {
    on<LoadFormDataRequested>(_onLoadFormData);
    on<FormLocationUpdated>(_onFormLocationUpdated);
    on<FormLocationErrorOccurred>(_onFormLocationErrorOccurred);
    on<ClearLocationRequested>(_onClearLocationRequested);
    on<SaveObservationRequested>(_onSaveObservation);
  }

  final GetBirdsUseCase getBirdsUseCase;
  final SaveObservationUseCase saveObservationUseCase;
  final IAppLogger logger;

  Future<void> _onLoadFormData(
    LoadFormDataRequested event,
    Emitter<ObservationFormState> emit,
  ) async {
    emit(const ObservationFormLoading());
    final result = await getBirdsUseCase(event.langCode);

    result.when(
      success: (birds) {
        emit(
          ObservationFormReady(
            birds: birds,
            geoPosition: event.existingLocation,
          ),
        );
      },
      failure: (failure) {
        logger.failure(failure);
        emit(ObservationFormError(failure: failure));
      },
    );
  }

  void _onFormLocationUpdated(
    FormLocationUpdated event,
    Emitter<ObservationFormState> emit,
  ) {
    if (state is ObservationFormReady) {
      emit(
        (state as ObservationFormReady).copyWith(
          geoPosition: event.position,
          clearError: true,
        ),
      );
    }
  }

  void _onFormLocationErrorOccurred(
    FormLocationErrorOccurred event,
    Emitter<ObservationFormState> emit,
  ) {
    if (state is ObservationFormReady) {
      emit(
        (state as ObservationFormReady).copyWith(
          locationError: event.error,
          clearLocation: true,
        ),
      );
    }
  }

  void _onClearLocationRequested(
    ClearLocationRequested event,
    Emitter<ObservationFormState> emit,
  ) {
    if (state is ObservationFormReady) {
      emit(
        (state as ObservationFormReady).copyWith(
          clearLocation: true,
          clearError: true,
        ),
      );
    }
  }

  Future<void> _onSaveObservation(
    SaveObservationRequested event,
    Emitter<ObservationFormState> emit,
  ) async {
    emit(const ObservationFormLoading());
    final result = await saveObservationUseCase(
      sessionId: event.sessionId,
      speciesId: event.speciesId,
      contactType: event.contactType,
      quantity: event.quantity,
      bearing: event.bearing,
      startTime: event.startTime,
      endTime: event.endTime,
      location: event.location,
      locationError: event.locationError,
      notes: event.notes,
      existingRecord: event.existingRecord,
      newGlobalDate: event.newGlobalDate,
    );

    result.when(
      success: (_) => emit(const ObservationFormSuccess()),
      failure: (failure) {
        logger.failure(failure);
        emit(ObservationFormError(failure: failure));
      },
    );
  }
}
