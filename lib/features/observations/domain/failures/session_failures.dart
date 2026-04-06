import 'package:noctambuls/core/error/failure.dart';

sealed class SessionFailure extends Failure {
  const SessionFailure({
    required super.debugMessage,
    required super.statusCode,
    super.stackTrace,
  });
}

final class ActiveSessionAlreadyExistsFailure extends SessionFailure {
  const ActiveSessionAlreadyExistsFailure({
    super.debugMessage = 'An active session already exists',
    super.statusCode = 409,
    super.stackTrace,
  });

  @override
  ActiveSessionAlreadyExistsFailure withDebug(
    Object error, [
    StackTrace? stackTrace,
  ]) => this;
}

final class SessionNotFoundFailure extends SessionFailure {
  const SessionNotFoundFailure({
    super.debugMessage = 'Session could not be found',
    super.statusCode = 404,
    super.stackTrace,
  });

  @override
  SessionNotFoundFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      this;
}
