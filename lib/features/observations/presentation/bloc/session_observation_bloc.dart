import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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

  StreamSubscription<List<ObservationRecord>>? _observationsSubscription;

  Future<void> _onWatchObservations(
    WatchObservations event,
    Emitter<SessionObservationState> emit,
  ) async {
    await _observationsSubscription?.cancel();
    _observationsSubscription = watchObservationsUseCase(sessionId).listen(
      (obs) => add(ObservationsStreamUpdated(obs)),
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
    try {
      await addObservationUseCase(event.record);
    } on Object catch (_) {
      emit(const ObservationsError());
    }
  }

  Future<void> _onDeleteRecord(
    DeleteRecord event,
    Emitter<SessionObservationState> emit,
  ) async {
    try {
      await deleteObservationUseCase(event.recordId);
    } on Object catch (_) {
      emit(const ObservationsError());
    }
  }

  @override
  Future<void> close() async {
    await _observationsSubscription?.cancel();
    return super.close();
  }
}
