import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';

class ObservationSession extends Equatable {
  const ObservationSession({
    required this.id,
    required this.annotatorId,
    required this.sessionType,
    required this.createdAt,
    required this.updatedAt,
    this.startTime,
    this.endTime,
    this.temperature = TemperatureRange.belowZero,
    this.wind = WindLevel.calm,
    this.sky = SkyCondition.clear,
    this.rain = RainLevel.none,
    this.visibility = VisibilityLevel.poor,
    this.moon = MoonPresence.absent,
    this.listeningPoint,
    this.location,
    this.locationError,
    this.participants = const [],
    this.isLocked = false,
    this.syncStatus = SyncStatus.draft,
    this.isDeleted = false,
  });

  final String id;
  final String annotatorId;
  final SessionType sessionType;
  final DateTime? startTime;
  final DateTime? endTime;
  final TemperatureRange temperature;
  final WindLevel wind;
  final SkyCondition sky;
  final RainLevel rain;
  final VisibilityLevel visibility;
  final MoonPresence moon;
  final int? listeningPoint;
  final GeoPosition? location;
  final LocationErrorType? locationError;
  final bool isLocked;
  final SyncStatus syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final List<String> participants;

  bool get isObserving => endTime == null && !isLocked && !isDeleted;

  bool get isReviewing => endTime != null && !isLocked && !isDeleted;

  bool get isFinished => isLocked && !isDeleted;

  bool get canEditObservationDate =>
      sessionType == SessionType.incidental && isObserving;

  DateTime? get observationTimeMin =>
      (sessionType == SessionType.census || sessionType == SessionType.station)
      ? startTime
      : null;

  DateTime? get observationTimeMax =>
      (sessionType == SessionType.census || sessionType == SessionType.station)
      ? endTime
      : null;

  bool get needsListeningPoint =>
      sessionType == SessionType.census || sessionType == SessionType.station;

  bool get needsLocation =>
      sessionType == SessionType.census || sessionType == SessionType.station;

  bool get isIncidental => sessionType == SessionType.incidental;

  static const Object _absent = Object();

  ObservationSession copyWith({
    required DateTime updatedAt,
    DateTime? startTime,
    Object? endTime = _absent,
    TemperatureRange? temperature,
    WindLevel? wind,
    SkyCondition? sky,
    RainLevel? rain,
    VisibilityLevel? visibility,
    MoonPresence? moon,
    Object? listeningPoint = _absent,
    Object? location = _absent,
    Object? locationError = _absent,
    bool? isLocked,
    SyncStatus? syncStatus,
    bool? isDeleted,
    List<String>? participants,
  }) {
    return ObservationSession(
      id: id,
      annotatorId: annotatorId,
      sessionType: sessionType,
      startTime: startTime ?? this.startTime,
      endTime: identical(endTime, _absent)
          ? this.endTime
          : endTime as DateTime?,
      temperature: temperature ?? this.temperature,
      wind: wind ?? this.wind,
      sky: sky ?? this.sky,
      rain: rain ?? this.rain,
      visibility: visibility ?? this.visibility,
      moon: moon ?? this.moon,
      listeningPoint: identical(listeningPoint, _absent)
          ? this.listeningPoint
          : listeningPoint as int?,
      location: identical(location, _absent)
          ? this.location
          : location as GeoPosition?,
      locationError: identical(locationError, _absent)
          ? this.locationError
          : locationError as LocationErrorType?,
      participants: participants ?? this.participants,
      isLocked: isLocked ?? this.isLocked,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
    id,
    annotatorId,
    sessionType,
    startTime,
    endTime,
    temperature,
    wind,
    sky,
    rain,
    visibility,
    moon,
    listeningPoint,
    location,
    locationError,
    participants,
    isLocked,
    syncStatus,
    createdAt,
    updatedAt,
    isDeleted,
  ];
}
