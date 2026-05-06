import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_all_sessions_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_state.dart';

class SessionListBloc extends Bloc<SessionListEvent, SessionListState> {
  SessionListBloc({required this.watchAllSessionsUseCase, required this.logger})
    : super(SessionListLoading()) {
    on<WatchAllSessionsRequested>(_onWatchAllSessions);
    on<SessionsStreamUpdated>(_onSessionsStreamUpdated);
  }

  final WatchAllSessionsUseCase watchAllSessionsUseCase;
  final IAppLogger logger;
  StreamSubscription<List<ObservationSession>>? _subscription;

  Future<void> _onWatchAllSessions(
    WatchAllSessionsRequested event,
    Emitter<SessionListState> emit,
  ) async {
    emit(SessionListLoading());
    await _subscription?.cancel();

    _subscription = watchAllSessionsUseCase().listen(
      (sessions) => add(SessionsStreamUpdated(sessions)),
      onError: (Object error) {
        emit(const SessionListError(UnknownFailure()));
        logger.warning(error.toString());
      },
    );
  }

  void _onSessionsStreamUpdated(
    SessionsStreamUpdated event,
    Emitter<SessionListState> emit,
  ) {
    emit(SessionListLoaded(event.sessions));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
