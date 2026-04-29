import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_observations_for_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';

class SessionObservationBloc
    extends Bloc<SessionObservationEvent, SessionObservationState> {
  SessionObservationBloc({
    required this.sessionId,
    required this.watchObservationsUseCase,
    required this.addObservationUseCase,
    required this.deleteObservationUseCase,
    required this.logger,
  }) : super(const ObservationsInitial()) {
    on<WatchObservations>(_onWatchObservations);
    on<ObservationsStreamUpdated>(_onObservationsStreamUpdated);
    on<AddRecord>(_onAddRecord);
    on<DeleteRecord>(_onDeleteRecord);
  }

  final String sessionId;
  final WatchObservationsForSessionUseCase watchObservationsUseCase;
  final AddObservationUseCase addObservationUseCase;
  final DeleteObservationUseCase deleteObservationUseCase;
  final IAppLogger logger;

  StreamSubscription<List<ObservationRecord>>? _observationsSubscription;

  Future<void> _onWatchObservations(
    WatchObservations event,
    Emitter<SessionObservationState> emit,
  ) async {
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
    emit(ObservationsLoaded(event.observations));
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

  @override
  Future<void> close() async {
    await _observationsSubscription?.cancel();
    return super.close();
  }
}
