import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/usecases/url/open_url_usecase.dart';

class OpenMapsUrlUseCase {
  const OpenMapsUrlUseCase(this._openUrlUseCase, this.googleMapsUrl);

  final OpenUrlUseCase _openUrlUseCase;
  final String googleMapsUrl;

  Future<Result<Unit>> call(double latitude, double longitude) {
    final url = '$googleMapsUrl$latitude,$longitude';

    return _openUrlUseCase(url);
  }
}
