import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_all_observations_date_usecase.dart';
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
    required this.updateAllObservationsDateUseCase,
    required this.deleteObservationUseCase,
    required this.getBirdsUseCase,
    required this.getLanguageUseCase,
    required this.logger,
  }) : super(const ObservationsInitial()) {
    on<WatchObservations>(_onWatchObservations);
    on<ObservationsStreamUpdated>(_onObservationsStreamUpdated);
    on<DeleteRecord>(_onDeleteRecord);
    on<UpdateAllObservationsDate>(_onUpdateAllObservationsDate);
  }

  final String sessionId;
  final WatchObservationsForSessionUseCase watchObservationsUseCase;
  final DeleteObservationUseCase deleteObservationUseCase;
  final UpdateAllObservationsDateUseCase updateAllObservationsDateUseCase;
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

    final result = await updateAllObservationsDateUseCase(
      observations,
      event.date,
    );

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
