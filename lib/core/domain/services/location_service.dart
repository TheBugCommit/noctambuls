import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';

abstract interface class LocationService {
  Future<Result<GeoPosition>> getLastKnownLocation();

  Future<Result<GeoPosition>> getLocation();

  Stream<GeoPosition> getLocationStream();
}
