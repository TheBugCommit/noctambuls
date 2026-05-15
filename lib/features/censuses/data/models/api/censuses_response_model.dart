import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/censuses/data/models/census_model.dart';

part 'censuses_response_model.freezed.dart';
part 'censuses_response_model.g.dart';

@freezed
abstract class CensusesResponseModel with _$CensusesResponseModel {
  const factory CensusesResponseModel({
    required List<CensusRemoteDto> censuses,
    required String serverTime,
  }) = _CensusesResponseModel;

  factory CensusesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CensusesResponseModelFromJson(json);
}

@freezed
abstract class CensusRemoteDto with _$CensusRemoteDto {
  const factory CensusRemoteDto({
    required String id,
    required String title,
    required String date,
    required String time,
    required String updatedAt,
    double? latitude,
    double? longitude,
    String? locationName,
    String? description,
  }) = _CensusRemoteDto;

  factory CensusRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$CensusRemoteDtoFromJson(json);
}

extension CensusRemoteDtoX on CensusRemoteDto {
  CensusModel toModel() {
    final startTime = DateTime.parse('${date}T${time}:00Z').toUtc();
    final serverUpdatedAt = DateTime.parse(updatedAt).toUtc();
    final now = DateTime.now().toUtc();

    GeoPosition? geoPosition;
    if (latitude != null && longitude != null) {
      geoPosition = GeoPosition(
        latitude: latitude!,
        longitude: longitude!,
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        timestamp: serverUpdatedAt,
        locationSource: LocationSource.gps,
      );
    }

    return CensusModel(
      id: id,
      title: title,
      startTime: startTime,
      locationName: locationName,
      description: description,
      geoPosition: geoPosition,
      createdAt: now,
      updatedAt: serverUpdatedAt,
    );
  }
}
