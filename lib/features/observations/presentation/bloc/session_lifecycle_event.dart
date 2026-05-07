import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';

sealed class SessionLifecycleEvent extends Equatable {
  const SessionLifecycleEvent();

  @override
  List<Object?> get props => [];
}

/// Start watching active session event
class WatchSession extends SessionLifecycleEvent {}

/// Stream updated (datasource) event
class SessionStreamUpdated extends SessionLifecycleEvent {
  const SessionStreamUpdated(this.session);

  final ObservationSession? session;

  @override
  List<Object?> get props => [session];
}

/// Crea una nova sessió del tipus indicat.
class StartNewSession extends SessionLifecycleEvent {
  const StartNewSession({
    required this.sessionType,
    required this.annotatorId,
  });

  final SessionType sessionType;
  final String annotatorId;

  @override
  List<Object?> get props => [sessionType, annotatorId];
}

/// Updates any session property event
class UpdateSessionProperties extends SessionLifecycleEvent {
  const UpdateSessionProperties({
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

/// Transition event to SessionReviewing
class StopObservationPhase extends SessionLifecycleEvent {}

/// Transition event from SessionReviewing back to SessionObserving
class ResumeObservationPhase extends SessionLifecycleEvent {}

/// Transition event to SessionFinished
class FinishAndLockSession extends SessionLifecycleEvent {}

/// Delete active session event
class DeleteSession extends SessionLifecycleEvent {}

/// Changes the globally selected observation date for incidental sessions.
class ChangeObservationDate extends SessionLifecycleEvent {
  const ChangeObservationDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

/// Dismiss an error an returns to SessionLifecycleIdle event
class DismissError extends SessionLifecycleEvent {}
