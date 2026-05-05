import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_state.dart';
import 'package:uuid/uuid.dart';

class ObservationFormBloc
    extends Bloc<ObservationFormEvent, ObservationFormState> {
  ObservationFormBloc({
    required this.getBirdsUseCase,
    required this.logger,
  }) : super(const ObservationFormInitial()) {
    on<LoadFormDataRequested>(_onLoadFormData);
    on<SaveObservationRequested>(_onSaveObservation);
  }

  final GetBirdsUseCase getBirdsUseCase;
  final IAppLogger logger;

  Future<void> _onLoadFormData(
    LoadFormDataRequested event,
    Emitter<ObservationFormState> emit,
  ) async {
    emit(const ObservationFormLoading());

    final result = await getBirdsUseCase(event.langCode);

    result.when(
      success: (birds) {
        emit(ObservationFormReady(birds: birds));
      },
      failure: (failure) {
        logger.failure(failure);
        emit(ObservationFormError(failure: failure));
      },
    );
  }

  void _onSaveObservation(
    SaveObservationRequested event,
    Emitter<ObservationFormState> emit,
  ) {
    emit(const ObservationFormLoading());

    final isEditing = event.existingRecord != null;
    final now = DateTime.now();

    final record = ObservationRecord(
      id: isEditing ? event.existingRecord!.id : const Uuid().v4(),
      sessionId: event.sessionId,
      speciesId: event.speciesId,
      contactType: event.contactType,
      quantity: event.quantity,
      notes: event.notes,
      startTime: isEditing ? event.existingRecord!.startTime : now,
      endTime: isEditing ? event.existingRecord!.endTime : now,
      createdAt: isEditing ? event.existingRecord!.createdAt : now,
      updatedAt: now,
      latitude: event.existingRecord?.latitude,
      longitude: event.existingRecord?.longitude,
      bearing: event.existingRecord?.bearing,
      validationStatus:
          event.existingRecord?.validationStatus ?? ValidationStatus.pending,
      syncStatus: SyncStatus.draft,
    );

    if (isEditing) {
      event.sessionBloc.add(UpdateRecord(record));
    } else {
      event.sessionBloc.add(AddRecord(record));
    }

    emit(const ObservationFormSuccess());
  }
}
