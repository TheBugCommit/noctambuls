import 'dart:async';
import 'dart:io';

import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  @override
  Future<Result<Unit>> checkConnectivity() async {
    try {
      final socket = await Socket.connect(
        '8.8.8.8',
        53,
        timeout: const Duration(seconds: 3),
      );

      socket.destroy();
      return const Ok(Unit.instance);
    } on SocketException catch (_) {
      return const Err(
        NetworkFailure(debugMessage: 'Socket error'),
      );
    } on TimeoutException catch (_) {
      return const Err(
        NetworkFailure(debugMessage: 'Socket timeout'),
      );
    } catch (_) {
      return const Err(
        NetworkFailure(debugMessage: 'Unknown error'),
      );
    }
  }
}
