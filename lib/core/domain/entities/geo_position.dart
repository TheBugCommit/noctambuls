import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';

class GeoPosition extends Equatable {
  const GeoPosition({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.altitudeAccuracy,
    required this.timestamp,
    required this.locationSource,
  });

  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double altitudeAccuracy;
  final DateTime timestamp;
  final LocationSource locationSource;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    accuracy,
    altitude,
    altitudeAccuracy,
    timestamp,
    locationSource,
  ];
}
