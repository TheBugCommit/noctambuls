import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:noctambuls/core/domain/error/failure.dart';

abstract class IAppLogger {
  void info(String message);

  void warning(String message);

  void failure(Failure failure);
}

class AppLogger implements IAppLogger {
  AppLogger._();

  static final AppLogger instance = AppLogger._();

  @override
  void info(String message) {
    if (kDebugMode) {
      developer.log(message, name: 'INFO');
    }
  }

  @override
  void warning(String message) {
    if (kDebugMode) {
      developer.log(message, name: 'WARNING');
    }
  }

  @override
  void failure(Failure failure) {
    if (kDebugMode) {
      developer.log(
        '[${failure.statusCode}] ${failure.debugMessage}',
        name: 'FAILURE',
        error: failure,
        stackTrace: failure.stackTrace,
      );
    }
  }
}
