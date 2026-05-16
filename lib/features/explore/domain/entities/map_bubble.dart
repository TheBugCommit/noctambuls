import 'package:equatable/equatable.dart';

class MapBubble extends Equatable {
  const MapBubble({
    required this.speciesId,
    required this.lat,
    required this.lon,
    required this.year,
    required this.count,
  });

  final String speciesId;
  final double lat;
  final double lon;
  final int year;
  final int count;

  @override
  List<Object?> get props => [speciesId, lat, lon, year, count];
}
