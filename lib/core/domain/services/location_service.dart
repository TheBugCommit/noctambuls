import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';

abstract class LocationService {
  Future<Result<GeoPosition>> getLastKnownLocation();

  Future<Result<GeoPosition>> getLocation();
}
