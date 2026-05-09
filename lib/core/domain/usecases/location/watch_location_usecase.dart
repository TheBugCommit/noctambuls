import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';

class WatchLocationUseCase {
  const WatchLocationUseCase(this._locationService);

  final LocationService _locationService;

  Stream<GeoPosition> call() {
    return _locationService.getLocationStream();
  }
}
