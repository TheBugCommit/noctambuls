import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';

class ObservationSession extends Equatable {
  const ObservationSession({
    required this.id,
    required this.annotatorId,
    required this.sessionType,
    required this.createdAt,
    required this.updatedAt,
    this.startTime,
    this.endTime,
    this.weatherNotes,
    this.latitude,
    this.longitude,
    this.isLocked = false,
    this.syncStatus = SyncStatus.draft,
    this.isDeleted = false,
  });

  final String id;
  final String annotatorId;
  final SessionType sessionType;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? weatherNotes;
  final double? latitude;
  final double? longitude;
  final bool isLocked;
  final SyncStatus syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  bool get isObserving => endTime == null && !isLocked && !isDeleted;

  bool get isReviewing => endTime != null && !isLocked && !isDeleted;

  bool get isFinished => isLocked && !isDeleted;

  static const Object _absent = Object();

  ObservationSession copyWith({
    required DateTime updatedAt,
    Object? endTime = _absent,
    Object? weatherNotes = _absent,
    Object? latitude = _absent,
    Object? longitude = _absent,
    bool? isLocked,
    SyncStatus? syncStatus,
    bool? isDeleted,
  }) {
    return ObservationSession(
      id: id,
      annotatorId: annotatorId,
      sessionType: sessionType,
      startTime: startTime,
      endTime: identical(endTime, _absent)
          ? this.endTime
          : endTime as DateTime?,
      weatherNotes: identical(weatherNotes, _absent)
          ? this.weatherNotes
          : weatherNotes as String?,
      latitude: identical(latitude, _absent)
          ? this.latitude
          : latitude as double?,
      longitude: identical(longitude, _absent)
          ? this.longitude
          : longitude as double?,
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
    weatherNotes,
    latitude,
    longitude,
    isLocked,
    syncStatus,
    createdAt,
    updatedAt,
    isDeleted,
  ];
}
