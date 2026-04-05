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
    this.syncStatus = SyncStatus.pending,
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

  ObservationSession copyWith({
    DateTime? endTime,
    String? weatherNotes,
    bool? isLocked,
    SyncStatus? syncStatus,
    bool? isDeleted,
    DateTime? updatedAt,
  }) {
    return ObservationSession(
      id: id,
      annotatorId: annotatorId,
      sessionType: sessionType,
      startTime: startTime,
      endTime: endTime ?? this.endTime,
      weatherNotes: weatherNotes ?? this.weatherNotes,
      latitude: latitude,
      longitude: longitude,
      isLocked: isLocked ?? this.isLocked,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
