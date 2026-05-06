import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class SessionListState extends Equatable {
  const SessionListState();

  @override
  List<Object?> get props => [];
}

final class SessionListLoading extends SessionListState {}

final class SessionListLoaded extends SessionListState {
  const SessionListLoaded(this.sessions);

  final List<ObservationSession> sessions;

  @override
  List<Object?> get props => [sessions];
}

final class SessionListError extends SessionListState {
  const SessionListError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
