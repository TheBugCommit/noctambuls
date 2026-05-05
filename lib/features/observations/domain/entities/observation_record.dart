import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';

class ObservationRecord extends Equatable {
  const ObservationRecord({
    required this.id,
    required this.sessionId,
    required this.speciesId,
    required this.contactType,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    this.quantity = 1,
    this.notes,
    this.latitude,
    this.longitude,
    this.bearing,
    this.validationStatus = ValidationStatus.pending,
    this.syncStatus = SyncStatus.draft,
    this.isDeleted = false,
  });

  final String id;
  final String sessionId;
  final String speciesId;
  final ContactType contactType;
  final int quantity;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final double? latitude;
  final double? longitude;
  final double? bearing;
  final ValidationStatus validationStatus;
  final SyncStatus syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  static const Object _absent = Object();

  ObservationRecord copyWith({
    required DateTime updatedAt,
    Object? notes = _absent,
    Object? latitude = _absent,
    Object? longitude = _absent,
    Object? bearing = _absent,
    int? quantity,
    ValidationStatus? validationStatus,
    SyncStatus? syncStatus,
    bool? isDeleted,
  }) {
    return ObservationRecord(
      id: id,
      sessionId: sessionId,
      speciesId: speciesId,
      contactType: contactType,
      quantity: quantity ?? this.quantity,
      startTime: startTime,
      endTime: endTime,
      notes: identical(notes, _absent) ? this.notes : notes as String?,
      latitude: identical(latitude, _absent)
          ? this.latitude
          : latitude as double?,
      longitude: identical(longitude, _absent)
          ? this.longitude
          : longitude as double?,
      bearing: identical(bearing, _absent) ? this.bearing : bearing as double?,
      validationStatus: validationStatus ?? this.validationStatus,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
    id,
    sessionId,
    speciesId,
    contactType,
    quantity,
    startTime,
    endTime,
    notes,
    latitude,
    longitude,
    bearing,
    validationStatus,
    syncStatus,
    createdAt,
    updatedAt,
    isDeleted,
  ];
}
