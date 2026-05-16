import 'package:equatable/equatable.dart';

class MapBounds extends Equatable {
  const MapBounds({
    required this.minLat,
    required this.maxLat,
    required this.minLon,
    required this.maxLon,
  });

  final double minLat; // Sud
  final double maxLat; // Nord
  final double minLon; // Oest
  final double maxLon; // Est

  bool contains(double lat, double lon) {
    return lat >= minLat && lat <= maxLat && lon >= minLon && lon <= maxLon;
  }

  @override
  List<Object?> get props => [minLat, maxLat, minLon, maxLon];
}
