import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';

part 'census_model.freezed.dart';

@freezed
abstract class CensusModel with _$CensusModel {
  const factory CensusModel({
    required String id,
    required String title,
    required DateTime startTime,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? locationName,
    String? description,
    GeoPosition? geoPosition,
    @Default(false) bool isJoined,
    @Default(false) bool alreadyDone,
  }) = _CensusModel;

  factory CensusModel.fromEntity(Census entity) {
    return CensusModel(
      id: entity.id,
      title: entity.title,
      startTime: entity.startTime,
      locationName: entity.locationName,
      description: entity.description,
      geoPosition: entity.geoPosition,
      isJoined: entity.isJoined,
      alreadyDone: entity.alreadyDone,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory CensusModel.fromData(CensusEntityData data) {
    GeoPosition? geoPosition;
    if (data.latitude != null && data.longitude != null) {
      geoPosition = GeoPosition(
        latitude: data.latitude!,
        longitude: data.longitude!,
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        timestamp: data.updatedAt,
        locationSource: LocationSource.gps,
      );
    }
    return CensusModel(
      id: data.id,
      title: data.title,
      startTime: data.startTime,
      locationName: data.locationName,
      description: data.description,
      geoPosition: geoPosition,
      isJoined: data.isJoined,
      alreadyDone: data.alreadyDone,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}

extension CensusModelX on CensusModel {
  Census toDomain() {
    return Census(
      id: id,
      title: title,
      startTime: startTime,
      locationName: locationName,
      description: description,
      geoPosition: geoPosition,
      isJoined: isJoined,
      alreadyDone: alreadyDone,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
