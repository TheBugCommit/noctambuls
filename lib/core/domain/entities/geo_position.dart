import 'package:equatable/equatable.dart';

class GeoPosition extends Equatable {
  const GeoPosition({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.altitudeAccuracy,
    required this.timestamp,
  });

  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double altitudeAccuracy;
  final DateTime timestamp;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    accuracy,
    altitude,
    altitudeAccuracy,
    timestamp,
  ];
}
