import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/get_active_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_observations_for_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/active_session_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/active_session_state.dart';

class ActiveSessionBloc extends Bloc<ActiveSessionEvent, ActiveSessionState> {
  ActiveSessionBloc({
    required this.watchActiveSessionUseCase,
    required this.getActiveSessionUseCase,
    required this.watchObservationsUseCase,
    required this.createSessionUseCase,
    required this.updateSessionUseCase,
    required this.addObservationUseCase,
    required this.deleteObservationUseCase,
  }) : super(const ActiveSessionState()) {
    on<StartWatchingActiveSession>(_onStartWatching);
    on<OnActiveSessionUpdated>(_onSessionUpdated);
    on<OnObservationsUpdated>(_onObservationsUpdated);

    on<StartNewSession>(_onStartNewSession);
    on<StopObservationPhase>(_onStopObservationPhase);
    on<FinishAndLockSession>(_onFinishAndLockSession);
    on<UpdateSessionNotes>(_onUpdateSessionNotes);

    on<AddRecord>(_onAddRecord);
    on<DeleteRecord>(_onDeleteRecord);
  }

  final WatchActiveSessionUseCase watchActiveSessionUseCase;
  final GetActiveSessionUseCase getActiveSessionUseCase;
  final WatchObservationsForSessionUseCase watchObservationsUseCase;
  final CreateSessionUseCase createSessionUseCase;
  final UpdateSessionUseCase updateSessionUseCase;
  final AddObservationUseCase addObservationUseCase;
  final DeleteObservationUseCase deleteObservationUseCase;

  StreamSubscription<ObservationSession?>? _sessionSubscription;
  StreamSubscription<List<ObservationRecord>>? _observationsSubscription;

  Future<void> _onStartWatching(
    StartWatchingActiveSession event,
    Emitter<ActiveSessionState> emit,
  ) async {
    await _sessionSubscription?.cancel();
    _sessionSubscription = watchActiveSessionUseCase().listen((session) {
      add(OnActiveSessionUpdated(session));
    });
  }

  Future<void> _onSessionUpdated(
    OnActiveSessionUpdated event,
    Emitter<ActiveSessionState> emit,
  ) async {
    if (event.session == null) {
      await _observationsSubscription?.cancel();
      emit(state.copyWith(clearSession: true, observations: []));
    } else {
      if (event.session!.id != state.session?.id) {
        await _observationsSubscription?.cancel();
        _observationsSubscription = watchObservationsUseCase(event.session!.id)
            .listen((obs) {
              add(OnObservationsUpdated(obs));
            });
      }
      emit(state.copyWith(session: event.session));
    }
  }

  void _onObservationsUpdated(
    OnObservationsUpdated event,
    Emitter<ActiveSessionState> emit,
  ) {
    emit(state.copyWith(observations: event.observations));
  }

  Future<void> _onStartNewSession(
    StartNewSession event,
    Emitter<ActiveSessionState> emit,
  ) async {
    if (state.hasActiveSession) {
      return;
    }
    await createSessionUseCase(event.session);
  }

  Future<void> _onStopObservationPhase(
    StopObservationPhase event,
    Emitter<ActiveSessionState> emit,
  ) async {
    if (!state.isObserving) return;

    final updatedSession = state.session!.copyWith(
      endTime: DateTime.now(),
    );
    await updateSessionUseCase(updatedSession);
  }

  Future<void> _onUpdateSessionNotes(
    UpdateSessionNotes event,
    Emitter<ActiveSessionState> emit,
  ) async {
    if (state.session == null) return;

    final updatedSession = state.session!.copyWith(
      weatherNotes: event.weatherNotes,
    );
    await updateSessionUseCase(updatedSession);
  }

  Future<void> _onFinishAndLockSession(
    FinishAndLockSession event,
    Emitter<ActiveSessionState> emit,
  ) async {
    if (state.session == null) return;

    final lockedSession = state.session!.copyWith(isLocked: true);
    await updateSessionUseCase(lockedSession);
  }

  Future<void> _onAddRecord(
    AddRecord event,
    Emitter<ActiveSessionState> emit,
  ) async {
    if (!state.isObserving) {
      return;
    }
    await addObservationUseCase(event.record);
  }

  Future<void> _onDeleteRecord(
    DeleteRecord event,
    Emitter<ActiveSessionState> emit,
  ) async {
    await deleteObservationUseCase(event.recordId);
  }

  @override
  Future<void> close() async {
    await _sessionSubscription?.cancel();
    await _observationsSubscription?.cancel();
    return super.close();
  }
}
