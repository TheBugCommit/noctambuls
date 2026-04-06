import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';

sealed class SessionObservationState extends Equatable {
  const SessionObservationState();
}

/// State before receiving stream observations
final class ObservationsInitial extends SessionObservationState {
  const ObservationsInitial();

  @override
  List<Object?> get props => [];
}

/// State before observations are loaded
final class ObservationsLoaded extends SessionObservationState {
  const ObservationsLoaded(this.observations);

  final List<ObservationRecord> observations;

  @override
  List<Object?> get props => [observations];
}

/// Observation operation error state
final class ObservationsError extends SessionObservationState {
  const ObservationsError();

  @override
  List<Object?> get props => [];
}
