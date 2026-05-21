import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';
import 'package:noctambuls/core/logging/app_logger.dart';

class LocationServiceImpl implements LocationService {
  LocationServiceImpl({required this.logger});

  final IAppLogger logger;
  Future<bool>? _permissionRequestFuture;
  bool _softDenied = false;

  @override
  Future<Result<GeoPosition>> getLocation() async {
    final permResult = await _checkPermissions();
    if (permResult is Err<Unit>) {
      return Err(permResult.failure);
    }

    try {
      final lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) {
        final difference = DateTime.now().difference(lastPosition.timestamp);
        if (difference.inSeconds < 30) {
          logger.info(
            'Using cached GPS: (${difference.inSeconds}s)',
          );
          return Ok(_mapPosition(lastPosition));
        }
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5),
        ),
      );

      return Ok(_mapPosition(position));
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
          locationSource: LocationSource.gps,
        ),
      );
    } catch (e, st) {
      final failure = const GpsDisabledFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }

  @override
  Stream<GeoPosition> getLocationStream() {
    late LocationSettings locationSettings;

    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 20,
        intervalDuration: const Duration(seconds: 10),
      );
    } else if (Platform.isIOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 15,
        pauseLocationUpdatesAutomatically: true,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 15,
      );
    }

    return Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).map(_mapPosition);
  }

  Future<Result<Unit>> _checkPermissions() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return const Err(GpsDisabledFailure());
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _softDenied = false;
      return const Ok(Unit.instance);
    }

    if (permission == LocationPermission.deniedForever || _softDenied) {
      return const Err(PermissionDeniedFailure());
    }

    if (_permissionRequestFuture != null) {
      final granted = await _permissionRequestFuture!;
      if (!granted) _softDenied = true;
      return granted
          ? const Ok(Unit.instance)
          : const Err(PermissionDeniedFailure());
    }

    _permissionRequestFuture = _requestPermission();

    try {
      final granted = await _permissionRequestFuture!;
      if (!granted) _softDenied = true;
      return granted
          ? const Ok(Unit.instance)
          : const Err(PermissionDeniedFailure());
    } finally {
      _permissionRequestFuture = null;
    }
  }

  Future<bool> _requestPermission() async {
    final permission = await Geolocator.requestPermission();

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  GeoPosition _mapPosition(Position position) {
    return GeoPosition(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      altitude: position.altitude,
      altitudeAccuracy: position.altitudeAccuracy,
      timestamp: position.timestamp,
      locationSource: LocationSource.gps,
    );
  }
}
