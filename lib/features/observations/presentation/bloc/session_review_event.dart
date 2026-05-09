import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';

sealed class SessionReviewEvent extends Equatable {
  const SessionReviewEvent();

  @override
  List<Object?> get props => [];
}

class ReviewUpdateProperties extends SessionReviewEvent {
  const ReviewUpdateProperties({
    required this.observations,
    this.temperature,
    this.wind,
    this.sky,
    this.rain,
    this.visibility,
    this.moon,
    this.listeningPoint,
    this.location,
  });

  final TemperatureRange? temperature;
  final WindLevel? wind;
  final SkyCondition? sky;
  final RainLevel? rain;
  final VisibilityLevel? visibility;
  final MoonPresence? moon;
  final int? listeningPoint;
  final GeoPosition? location;
  final List<ObservationRecord> observations;

  @override
  List<Object?> get props => [
    temperature,
    wind,
    sky,
    rain,
    visibility,
    moon,
    listeningPoint,
    location,
    observations,
  ];
}

class ReviewValidateData extends SessionReviewEvent {
  const ReviewValidateData(this.observations);

  final List<ObservationRecord> observations;

  @override
  List<Object?> get props => [observations];
}

class ReviewAddParticipant extends SessionReviewEvent {
  const ReviewAddParticipant(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

class ReviewRemoveParticipant extends SessionReviewEvent {
  const ReviewRemoveParticipant(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

class ReviewFinalizeSession extends SessionReviewEvent {
  const ReviewFinalizeSession(this.observations);

  final List<ObservationRecord> observations;

  @override
  List<Object?> get props => [observations];
}

class ReviewDeleteSession extends SessionReviewEvent {}
