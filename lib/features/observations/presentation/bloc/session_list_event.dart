import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class SessionListEvent extends Equatable {
  const SessionListEvent();

  @override
  List<Object?> get props => [];
}

class SessionListStarted extends SessionListEvent {
  const SessionListStarted({required this.annotatorId});

  final String annotatorId;

  @override
  List<Object?> get props => [annotatorId];
}

// Internal events dispatched by the bloc from stream subscriptions.
class OwnSessionsUpdated extends SessionListEvent {
  const OwnSessionsUpdated(this.sessions);

  final List<ObservationSession> sessions;

  @override
  List<Object?> get props => [sessions];
}

class ParticipatedSessionsUpdated extends SessionListEvent {
  const ParticipatedSessionsUpdated(this.sessions);

  final List<ObservationSession> sessions;

  @override
  List<Object?> get props => [sessions];
}

class FetchHistoryRequested extends SessionListEvent {
  const FetchHistoryRequested({this.isRefresh = false});

  final bool isRefresh;

  @override
  List<Object?> get props => [isRefresh];
}

class FetchParticipatedRequested extends SessionListEvent {
  const FetchParticipatedRequested({this.isRefresh = false});

  final bool isRefresh;

  @override
  List<Object?> get props => [isRefresh];
}

class HistoryScrollReachedEnd extends SessionListEvent {}

class ParticipatedScrollReachedEnd extends SessionListEvent {}

class SyncAllPendingRequested extends SessionListEvent {}

class RetrySyncSessionRequested extends SessionListEvent {
  const RetrySyncSessionRequested(this.sessionId);

  final String sessionId;

  @override
  List<Object?> get props => [sessionId];
}
