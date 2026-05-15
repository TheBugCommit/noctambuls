import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';

abstract class CensusEvent extends Equatable {
  const CensusEvent();

  @override
  List<Object?> get props => [];
}

class CensusStarted extends CensusEvent {}

class JoinCensusByUrl extends CensusEvent {
  const JoinCensusByUrl(this.url);

  final String url;

  @override
  List<Object?> get props => [url];
}

class AbandonCensus extends CensusEvent {
  const AbandonCensus(this.censusId);

  final String censusId;

  @override
  List<Object?> get props => [censusId];
}

class StartCensusSession extends CensusEvent {
  const StartCensusSession({required this.census, required this.annotatorId});

  final Census census;
  final String annotatorId;

  @override
  List<Object?> get props => [census, annotatorId];
}

class DismissCensusError extends CensusEvent {}
