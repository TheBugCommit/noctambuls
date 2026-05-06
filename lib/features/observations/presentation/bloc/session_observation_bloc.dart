import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_observations_for_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';

class SessionObservationBloc
    extends Bloc<SessionObservationEvent, SessionObservationState> {
  SessionObservationBloc({
    required this.sessionId,
    required this.watchObservationsUseCase,
    required this.addObservationUseCase,
    required this.updateObservationUseCase,
    required this.deleteObservationUseCase,
    required this.getBirdsUseCase,
    required this.getLanguageUseCase,
    required this.logger,
  }) : super(const ObservationsInitial()) {
    on<WatchObservations>(_onWatchObservations);
    on<ObservationsStreamUpdated>(_onObservationsStreamUpdated);
    on<AddRecord>(_onAddRecord);
    on<UpdateRecord>(_onUpdateRecord);
    on<DeleteRecord>(_onDeleteRecord);
    on<UpdateAllObservationsDate>(_onUpdateAllObservationsDate);
  }

  final String sessionId;
  final WatchObservationsForSessionUseCase watchObservationsUseCase;
  final AddObservationUseCase addObservationUseCase;
  final UpdateObservationUseCase updateObservationUseCase;
  final DeleteObservationUseCase deleteObservationUseCase;
  final IAppLogger logger;
  final GetBirdsUseCase getBirdsUseCase;
  final GetLanguageUseCase getLanguageUseCase;
  Map<String, Bird> _birdsMap = {};

  StreamSubscription<List<ObservationRecord>>? _observationsSubscription;

  Future<void> _onWatchObservations(
    WatchObservations event,
    Emitter<SessionObservationState> emit,
  ) async {
    final langCode = getLanguageUseCase().toLanguageCode;
    final result = await getBirdsUseCase(langCode);
    result.when(
      success: (birds) {
        _birdsMap = {for (final b in birds) b.id: b};
      },
      failure: logger.failure,
    );

    await _observationsSubscription?.cancel();
    _observationsSubscription = watchObservationsUseCase(sessionId).listen(
      (obs) => add(ObservationsStreamUpdated(obs)),
      onError: (Object error, StackTrace stackTrace) {
        addError(error, stackTrace);
      },
    );
  }

  void _onObservationsStreamUpdated(
    ObservationsStreamUpdated event,
    Emitter<SessionObservationState> emit,
  ) {
    emit(
      ObservationsLoaded(
        observations: event.observations,
        birdsMap: _birdsMap,
      ),
    );
  }

  Future<void> _onAddRecord(
    AddRecord event,
    Emitter<SessionObservationState> emit,
  ) async {
    final result = await addObservationUseCase(event.record);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(ObservationsError(failure: failure));
      },
    );
  }

  Future<void> _onUpdateRecord(
    UpdateRecord event,
    Emitter<SessionObservationState> emit,
  ) async {
    final result = await updateObservationUseCase(event.record);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(ObservationsError(failure: failure));
      },
    );
  }

  Future<void> _onDeleteRecord(
    DeleteRecord event,
    Emitter<SessionObservationState> emit,
  ) async {
    final result = await deleteObservationUseCase(event.recordId);
    result.when(
      success: (_) {},
      failure: (failure) {
        logger.failure(failure);
        emit(ObservationsError(failure: failure));
      },
    );
  }

  Future<void> _onUpdateAllObservationsDate(
    UpdateAllObservationsDate event,
    Emitter<SessionObservationState> emit,
  ) async {
    if (state is! ObservationsLoaded) return;
    final observations = (state as ObservationsLoaded).observations;
    final d = event.date;

    for (final obs in observations) {
      final now = DateTime.now();
      var newStart = DateTime(
        d.year,
        d.month,
        d.day,
        obs.startTime.hour,
        obs.startTime.minute,
      );
      var newEnd = DateTime(
        d.year,
        d.month,
        d.day,
        obs.endTime.hour,
        obs.endTime.minute,
      );

      if (newStart.isAfter(now)) newStart = now;
      if (newEnd.isAfter(now)) newEnd = newStart;

      final updated = obs.copyWith(
        startTime: newStart,
        endTime: newEnd,
        updatedAt: now,
      );
      final result = await updateObservationUseCase(updated);
      result.when(
        success: (_) {},
        failure: logger.failure,
      );
    }
  }

  @override
  Future<void> close() async {
    await _observationsSubscription?.cancel();
    return super.close();
  }
}
