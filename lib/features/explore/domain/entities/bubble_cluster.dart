import 'package:equatable/equatable.dart';

class BubbleCluster extends Equatable {
  const BubbleCluster({
    required this.lat,
    required this.lon,
    required this.count,
    this.speciesId,
    this.year,
  });

  final double lat;
  final double lon;
  final int count;
  final String? speciesId;
  final int? year;

  bool get isCluster => speciesId == null;

  @override
  List<Object?> get props => [lat, lon, count, speciesId, year];
}
