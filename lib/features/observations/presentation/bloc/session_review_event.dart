import 'package:equatable/equatable.dart';
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
    this.temperature,
    this.wind,
    this.sky,
    this.rain,
    this.visibility,
    this.moon,
    this.listeningPoint,
    this.latitude,
    this.longitude,
  });

  final TemperatureRange? temperature;
  final WindLevel? wind;
  final SkyCondition? sky;
  final RainLevel? rain;
  final VisibilityLevel? visibility;
  final MoonPresence? moon;
  final int? listeningPoint;
  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [
    temperature,
    wind,
    sky,
    rain,
    visibility,
    moon,
    listeningPoint,
    latitude,
    longitude,
  ];
}

class ReviewFinalizeSession extends SessionReviewEvent {}

class ReviewDeleteSession extends SessionReviewEvent {}
