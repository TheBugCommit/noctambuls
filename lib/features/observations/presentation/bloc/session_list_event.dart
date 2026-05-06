import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class SessionListEvent extends Equatable {
  const SessionListEvent();

  @override
  List<Object?> get props => [];
}

class WatchAllSessionsRequested extends SessionListEvent {}

class SessionsStreamUpdated extends SessionListEvent {
  const SessionsStreamUpdated(this.sessions);

  final List<ObservationSession> sessions;

  @override
  List<Object?> get props => [sessions];
}
