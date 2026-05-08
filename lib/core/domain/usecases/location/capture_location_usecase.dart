import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';

class CaptureLocationUseCase {
  CaptureLocationUseCase({required this.locationService});

  final LocationService locationService;

  Future<Result<GeoPosition>> call() async {
    return locationService.getLocation();
  }
}
