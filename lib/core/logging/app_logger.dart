import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:noctambuls/core/error/failure.dart';

class AppLogger {
  AppLogger._();

  /// Logs an informational message.
  static void info(String message) {
    if (kDebugMode) {
      developer.log(message, name: 'INFO');
    }
  }

  /// Logs a warning message.
  static void warning(String message) {
    if (kDebugMode) {
      developer.log(message, name: 'WARNING');
    }
  }

  /// Logs a [Failure] with its status code, debug message and optional trace.
  static void failure(Failure failure) {
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
