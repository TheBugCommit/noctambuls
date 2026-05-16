import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';

part 'map_bubble_model.freezed.dart';

@freezed
abstract class MapBubbleModel with _$MapBubbleModel {
  const factory MapBubbleModel({
    required String id,
    required String speciesId,
    required double lat,
    required double lon,
    required int year,
    required int count,
    required DateTime updatedAt,
  }) = _MapBubbleModel;

  factory MapBubbleModel.fromData(MapBubbleData data) {
    return MapBubbleModel(
      id: data.id,
      speciesId: data.speciesId,
      lat: data.lat,
      lon: data.lon,
      year: data.year,
      count: data.count,
      updatedAt: data.updatedAt,
    );
  }

  static String computeId(
    String speciesId,
    double lat,
    double lon,
    int year,
  ) =>
      '${speciesId}_${lat.toStringAsFixed(6)}_${lon.toStringAsFixed(6)}_$year';
}

extension MapBubbleModelX on MapBubbleModel {
  MapBubble toDomain() {
    return MapBubble(
      speciesId: speciesId,
      lat: lat,
      lon: lon,
      year: year,
      count: count,
    );
  }
}
