import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    level: kReleaseMode ? Level.off : Level.all,
    printer: PrettyPrinter(
      errorMethodCount: 5,
      lineLength: 80,
    ),
  );

  static void i(String message) => _logger.i(message);

  static void d(String message) => _logger.d(message);

  static void w(String message) => _logger.w(message);

  static void e(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
