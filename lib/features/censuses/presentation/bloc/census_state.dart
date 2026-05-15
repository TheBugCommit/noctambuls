import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class CensusState extends Equatable {
  const CensusState();

  @override
  List<Object?> get props => [];
}

final class CensusInitial extends CensusState {
  const CensusInitial();
}

final class CensusLoaded extends CensusState {
  const CensusLoaded({required this.censuses, this.lobbyCensus});

  final List<Census> censuses;
  final Census? lobbyCensus;

  @override
  List<Object?> get props => [censuses, lobbyCensus];
}

/// One-shot state emitted when a join attempt fails.
/// The census list is preserved so the UI does not go blank.
final class CensusJoinError extends CensusState {
  const CensusJoinError({
    required this.failure,
    required this.censuses,
    this.lobbyCensus,
  });

  final Failure failure;
  final List<Census> censuses;
  final Census? lobbyCensus;

  @override
  List<Object?> get props => [failure, censuses, lobbyCensus];
}

/// One-shot state emitted once a census session is successfully started.
final class CensusSessionStarted extends CensusState {
  const CensusSessionStarted({required this.session});

  final ObservationSession session;

  @override
  List<Object?> get props => [session];
}
