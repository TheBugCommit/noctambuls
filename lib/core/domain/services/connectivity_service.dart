import 'package:noctambuls/core/domain/error/result.dart';

abstract interface class ConnectivityService {
  Future<Result<Unit>> checkConnectivity();
}
