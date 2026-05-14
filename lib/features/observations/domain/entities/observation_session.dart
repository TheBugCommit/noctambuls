import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';
import 'package:noctambuls/features/observations/domain/exceptions/session_exceptions.dart';
import 'package:noctambuls/features/observations/domain/failures/validation_failures.dart';

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
    this.observations = const [],
    this.isLocked = false,
    this.syncStatus = SyncStatus.draft,
    this.syncError,
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
  final SyncErrorType? syncError;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final List<String> participants;
  final List<ObservationRecord> observations;

  static const Object _absent = Object();

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

  ObservationSession addObservation(ObservationRecord observation) {
    if (isLocked) {
      throw const SessionUpdateException();
    }

    return copyWith(
      observations: [...observations, observation],
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession updateObservation(ObservationRecord observation) {
    if (isLocked) {
      throw const SessionUpdateException();
    }

    final newObservations = observations.map((obs) {
      return obs.id == observation.id ? observation : obs;
    }).toList();

    return copyWith(
      observations: newObservations,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession removeObservation(String observationId) {
    if (isLocked) {
      throw const SessionUpdateException();
    }

    final newObservations = observations
        .where((obs) => obs.id != observationId)
        .toList();

    return copyWith(
      observations: newObservations,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession addParticipant(String ornithologistCode) {
    if (isLocked) {
      throw const SessionUpdateException();
    }

    final regex = RegExp(r'^#OR-[A-Za-z]{1,4}-\d{4}$');
    if (!regex.hasMatch(ornithologistCode)) {
      throw const InvalidParticipantCodeException();
    }

    if (participants.contains(ornithologistCode)) {
      return this;
    }

    return copyWith(
      participants: [...participants, ornithologistCode],
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession removeParticipant(String ornithologistCode) {
    if (isLocked) return this;

    final newParticipants = participants
        .where((p) => p != ornithologistCode)
        .toList();

    return copyWith(
      participants: newParticipants,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession updateTimes({
    DateTime? newStartTime,
    DateTime? newEndTime,
  }) {
    final effectiveStart = newStartTime ?? startTime;
    final effectiveEnd = newEndTime ?? endTime;

    if (effectiveStart != null && effectiveEnd != null) {
      if (effectiveStart.isAfter(effectiveEnd)) {
        throw const InvalidSessionTimeException();
      }
    }

    return copyWith(
      startTime: effectiveStart,
      endTime: effectiveEnd,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession changeDate(DateTime newDate) {
    if (!canEditObservationDate) {
      throw const SessionUpdateException();
    }

    final nowUtc = DateTime.now().toUtc();

    DateTime? newSessionStart;
    if (startTime != null) {
      newSessionStart = DateTime.utc(
        newDate.year,
        newDate.month,
        newDate.day,
        startTime!.hour,
        startTime!.minute,
      );
      if (newSessionStart.isAfter(nowUtc)) newSessionStart = nowUtc;
    } else {
      newSessionStart = DateTime.utc(newDate.year, newDate.month, newDate.day);
    }

    final newObservations = observations.map((obs) {
      var newStart = DateTime.utc(
        newDate.year,
        newDate.month,
        newDate.day,
        obs.startTime.hour,
        obs.startTime.minute,
      );
      var newEnd = DateTime.utc(
        newDate.year,
        newDate.month,
        newDate.day,
        obs.endTime.hour,
        obs.endTime.minute,
      );

      if (newStart.isAfter(nowUtc)) newStart = nowUtc;
      if (newEnd.isAfter(nowUtc)) newEnd = newStart;

      return obs.copyWith(
        startTime: newStart,
        endTime: newEnd,
        updatedAt: nowUtc,
      );
    }).toList();

    return copyWith(
      startTime: newSessionStart,
      observations: newObservations,
      updatedAt: nowUtc,
    );
  }

  ObservationSession updateLocation({
    GeoPosition? location,
    Object? locationError = _absent,
  }) {
    if (isLocked) return this;

    final a = copyWith(
      location: location ?? this.location,
      locationError: identical(locationError, _absent)
          ? this.locationError
          : locationError as LocationErrorType?,
      updatedAt: DateTime.now().toUtc(),
    );
    return a;
  }

  ObservationSession updateProperties({
    TemperatureRange? temperature,
    WindLevel? wind,
    SkyCondition? sky,
    RainLevel? rain,
    VisibilityLevel? visibility,
    MoonPresence? moon,
    int? listeningPoint,
  }) {
    return copyWith(
      temperature: temperature ?? this.temperature,
      wind: wind ?? this.wind,
      sky: sky ?? this.sky,
      rain: rain ?? this.rain,
      visibility: visibility ?? this.visibility,
      moon: moon ?? this.moon,
      listeningPoint: listeningPoint ?? this.listeningPoint,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession finishAndLock() {
    if (isFinished) return this;

    final now = DateTime.now().toUtc();

    if (startTime != null && startTime!.isAfter(now)) {
      throw const InvalidSessionTimeException();
    }

    return copyWith(
      endTime: now,
      isLocked: true,
      updatedAt: now,
      syncStatus: SyncStatus.pending,
    );
  }

  ObservationSession finishSession() {
    if (!isObserving) {
      throw const SessionUpdateException();
    }

    final now = DateTime.now().toUtc();

    if (startTime != null && startTime!.isAfter(now)) {
      throw const InvalidSessionTimeException();
    }

    return copyWith(
      endTime: now,
      updatedAt: now,
    );
  }

  ObservationSession markAsSyncing() {
    return copyWith(
      syncStatus: SyncStatus.syncing,
      syncError: null,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession markAsSynced() {
    return copyWith(
      syncStatus: SyncStatus.synced,
      syncError: null,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession markAsFailed(String errorReason) {
    return copyWith(
      syncStatus: SyncStatus.error,
      syncError: errorReason,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession markBackToPending() {
    return copyWith(
      syncStatus: SyncStatus.pending,
      syncError: null,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ObservationSession markAsDeleted() {
    return copyWith(
      isDeleted: true,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  SessionValidationFailure? validateFinalization() {
    var missingSessionLocation = false;
    var missingObsLocations = <String>{};
    var missingListeningPoint = false;

    if (needsListeningPoint && listeningPoint == null) {
      missingListeningPoint = true;
    }

    if (isIncidental) {
      missingObsLocations = observations
          .where((o) => o.location == null)
          .map((o) => o.id)
          .toSet();
    } else {
      if (location == null) {
        missingSessionLocation = true;
      }
    }

    if (missingSessionLocation ||
        missingObsLocations.isNotEmpty ||
        missingListeningPoint) {
      return SessionValidationFailure(
        missingSessionLocation: missingSessionLocation,
        missingObservationLocationIds: missingObsLocations,
        missingListeningPoint: missingListeningPoint,
      );
    }

    return null;
  }

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
    Object? syncError = _absent,
    bool? isDeleted,
    List<String>? participants,
    List<ObservationRecord>? observations,
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
      observations: observations ?? this.observations,
      isLocked: isLocked ?? this.isLocked,
      syncStatus: syncStatus ?? this.syncStatus,
      syncError: identical(syncError, _absent)
          ? this.syncError
          : syncError as SyncErrorType?,
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
    observations,
    isLocked,
    syncStatus,
    syncError,
    createdAt,
    updatedAt,
    isDeleted,
  ];
}
