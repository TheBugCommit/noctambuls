import 'package:equatable/equatable.dart';

/// Base class for failures.
///
/// [stackTrace] are for logging only. Use [withDebug] to attach the caught
/// exception before logging.
abstract class Failure extends Equatable {
  const Failure({
    required this.debugMessage,
    required this.statusCode,
    this.stackTrace,
  });

  final String debugMessage;
  final int statusCode;
  final StackTrace? stackTrace;

  /// Returns a copy with [error] and optional [stackTrace] attached for
  /// logging.
  Failure withDebug(Object error, [StackTrace? stackTrace]);

  @override
  List<Object?> get props => [debugMessage, statusCode];
}
