import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';

sealed class SessionObservationState extends Equatable {
  const SessionObservationState();
}

/// Initial state before receiving stream data.
final class ObservationsInitial extends SessionObservationState {
  const ObservationsInitial();

  @override
  List<Object?> get props => [];
}

/// Observations loaded from stream.
final class ObservationsLoaded extends SessionObservationState {
  const ObservationsLoaded(this.observations);

  final List<ObservationRecord> observations;

  @override
  List<Object?> get props => [observations];
}

/// Observation operation failure state.
final class ObservationsError extends SessionObservationState {
  const ObservationsError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
