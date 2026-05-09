import 'package:noctambuls/core/domain/services/connectivity_service.dart';

class CheckInternetConnectionUseCase {
  const CheckInternetConnectionUseCase(this.service);

  final ConnectivityService service;

  Future<bool> call() async {
    final result = await service.checkConnectivity();
    return result.isOk;
  }
}
