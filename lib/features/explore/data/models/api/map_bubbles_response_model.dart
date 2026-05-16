import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/features/explore/data/models/map_bubble_model.dart';

part 'map_bubbles_response_model.freezed.dart';
part 'map_bubbles_response_model.g.dart';

@freezed
abstract class MapBubblesResponseModel with _$MapBubblesResponseModel {
  const factory MapBubblesResponseModel({
    required String serverTime,
    required List<MapBubbleDto> items,
  }) = _MapBubblesResponseModel;

  factory MapBubblesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MapBubblesResponseModelFromJson(json);
}

@freezed
abstract class MapBubbleDto with _$MapBubbleDto {
  const factory MapBubbleDto({
    @JsonKey(name: 'species_id') required String speciesId,
    required double lat,
    required double lon,
    required int year,
    required int count,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _MapBubbleDto;

  factory MapBubbleDto.fromJson(Map<String, dynamic> json) =>
      _$MapBubbleDtoFromJson(json);
}

extension MapBubbleDtoX on MapBubbleDto {
  MapBubbleModel toModel() {
    final id = MapBubbleModel.computeId(speciesId, lat, lon, year);
    return MapBubbleModel(
      id: id,
      speciesId: speciesId,
      lat: lat,
      lon: lon,
      year: year,
      count: count,
      updatedAt: DateTime.parse(updatedAt).toUtc(),
    );
  }
}
