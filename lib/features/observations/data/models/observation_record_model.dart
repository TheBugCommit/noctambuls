import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';

part 'observation_record_model.freezed.dart';

@freezed
abstract class ObservationRecordModel with _$ObservationRecordModel {
  const factory ObservationRecordModel({
    required String id,
    required String sessionId,
    required String speciesId,
    required ContactType contactType,
    required int quantity,
    required DateTime startTime,
    required DateTime endTime,
    required DateTime createdAt,
    required DateTime updatedAt,
    required double bearing,
    String? notes,
    GeoPosition? location,
    LocationErrorType? locationError,
    @Default(ValidationStatus.pending) ValidationStatus validationStatus,
    @Default(SyncStatus.draft) SyncStatus syncStatus,
    @Default(false) bool isDeleted,
  }) = _ObservationRecordModel;

  factory ObservationRecordModel.fromEntity(ObservationRecord entity) {
    return ObservationRecordModel(
      id: entity.id,
      sessionId: entity.sessionId,
      speciesId: entity.speciesId,
      contactType: entity.contactType,
      quantity: entity.quantity,
      startTime: entity.startTime,
      endTime: entity.endTime,
      notes: entity.notes,
      location: entity.location,
      locationError: entity.locationError,
      bearing: entity.bearing,
      validationStatus: entity.validationStatus,
      syncStatus: entity.syncStatus,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  factory ObservationRecordModel.fromData(ObservationEntityData data) {
    GeoPosition? location;
    if (data.latitude != null && data.longitude != null) {
      location = GeoPosition(
        latitude: data.latitude!,
        longitude: data.longitude!,
        accuracy: data.accuracy ?? 0.0,
        altitude: data.altitude ?? 0.0,
        altitudeAccuracy: data.altitudeAccuracy ?? 0.0,
        timestamp: data.positionTimestamp ?? data.createdAt,
        locationSource: data.locationSource ?? LocationSource.gps,
      );
    }

    return ObservationRecordModel(
      id: data.id,
      sessionId: data.sessionId,
      speciesId: data.speciesId,
      contactType: data.contactType,
      quantity: data.quantity,
      startTime: data.startTime,
      endTime: data.endTime,
      notes: data.notes,
      location: location,
      locationError: data.locationError,
      bearing: data.bearing,
      validationStatus: data.validationStatus,
      syncStatus: data.syncStatus,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isDeleted: data.isDeleted,
    );
  }
}

extension ObservationRecordModelX on ObservationRecordModel {
  ObservationRecord toDomain() {
    return ObservationRecord(
      id: id,
      sessionId: sessionId,
      speciesId: speciesId,
      contactType: contactType,
      quantity: quantity,
      startTime: startTime,
      endTime: endTime,
      notes: notes,
      location: location,
      locationError: locationError,
      bearing: bearing,
      validationStatus: validationStatus,
      syncStatus: syncStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
    );
  }
}
