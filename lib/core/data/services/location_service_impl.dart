import 'package:geolocator/geolocator.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationServiceImpl extends LocationService {
  LocationServiceImpl({required this.logger});

  final IAppLogger logger;

  @override
  Future<Result<GeoPosition>> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      logger.warning('GPS disabled');
      return const Err(GpsDisabledFailure());
    }

    var permission = await Permission.locationWhenInUse.status;
    if (permission.isDenied) {
      permission = await Permission.locationWhenInUse.request();
      if (permission.isDenied) {
        logger.warning('Location permission denied');
        return const Err(PermissionDeniedFailure());
      }
    }

    if (permission.isPermanentlyDenied) {
      logger.warning('Location permission permanently denied');
      return const Err(PermissionDeniedFailure());
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      return Ok(
        GeoPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          altitudeAccuracy: position.altitudeAccuracy,
          timestamp: position.timestamp,
        ),
      );
    } catch (e, st) {
      final failure = const GpsDisabledFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }

  @override
  Future<Result<GeoPosition>> getLastKnownLocation() async {
    try {
      final position = await Geolocator.getLastKnownPosition();

      if (position == null) {
        logger.warning('No last known location available');
        return const Err(GpsDisabledFailure());
      }

      return Ok(
        GeoPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          altitudeAccuracy: position.altitudeAccuracy,
          timestamp: position.timestamp,
        ),
      );
    } catch (e, st) {
      final failure = const GpsDisabledFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }
}
