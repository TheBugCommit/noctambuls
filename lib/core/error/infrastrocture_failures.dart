import 'package:noctambuls/core/error/failure.dart';

sealed class InfrastructureFailure extends Failure {
  const InfrastructureFailure({
    required super.debugMessage,
    required super.statusCode,
    super.stackTrace,
  });
}

/// Wraps unexpected errors not matching any specific failure type.
final class UnknownFailure extends Failure {
  const UnknownFailure({
    super.debugMessage = 'Unexpected error',
    super.statusCode = 500,
    super.stackTrace,
  });

  @override
  UnknownFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      UnknownFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

/// Wraps errors from local database operations.
final class DatabaseFailure extends Failure {
  const DatabaseFailure({
    super.debugMessage = 'Database operation failed',
    super.statusCode = 503,
    super.stackTrace,
  });

  @override
  DatabaseFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      DatabaseFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

/// Wraps errors from local cache operations.
final class CacheFailure extends Failure {
  const CacheFailure({
    super.debugMessage = 'Cache operation failed',
    super.statusCode = 503,
    super.stackTrace,
  });

  @override
  CacheFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      CacheFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}
