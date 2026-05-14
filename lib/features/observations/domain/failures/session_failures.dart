import 'package:noctambuls/core/domain/error/failure.dart';

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

final class ResumeSessionExpiredFailure extends SessionFailure {
  const ResumeSessionExpiredFailure({
    super.debugMessage = 'Cannot resume session after more than 1 hour',
    super.statusCode = 409,
    super.stackTrace,
  });

  @override
  ResumeSessionExpiredFailure withDebug(
    Object error, [
    StackTrace? stackTrace,
  ]) => this;
}

final class InvalidParticipantCodeFailure extends SessionFailure {
  const InvalidParticipantCodeFailure({
    super.debugMessage = 'The participant code format is invalid',
    super.statusCode = 400,
    super.stackTrace,
  });

  @override
  InvalidParticipantCodeFailure withDebug(
    Object error, [
    StackTrace? stackTrace,
  ]) => this;
}

final class SessionLockedFailure extends SessionFailure {
  const SessionLockedFailure({
    super.debugMessage = 'Cannot modify a locked or finished session',
    super.statusCode = 403,
    super.stackTrace,
  });

  @override
  SessionLockedFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      this;
}

final class ObservationMissingLocationFailure extends SessionFailure {
  const ObservationMissingLocationFailure({
    super.debugMessage =
        'Cannot add observation in incidental session without location',
    super.statusCode = 403,
    super.stackTrace,
  });

  @override
  ObservationMissingLocationFailure withDebug(
    Object error, [
    StackTrace? stackTrace,
  ]) => this;
}

final class SyncNetworkFailure extends SessionFailure {
  const SyncNetworkFailure({
    super.debugMessage = 'Sync failed: no network connection',
    super.statusCode = 0,
    super.stackTrace,
  });

  @override
  SyncNetworkFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      SyncNetworkFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class SyncServerFailure extends SessionFailure {
  const SyncServerFailure({
    super.debugMessage = 'Sync failed: server error',
    super.statusCode = 500,
    super.stackTrace,
  });

  @override
  SyncServerFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      SyncServerFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class FetchHistoryFailure extends SessionFailure {
  const FetchHistoryFailure({
    super.debugMessage = 'Could not fetch session history',
    super.statusCode = 500,
    super.stackTrace,
  });

  @override
  FetchHistoryFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      FetchHistoryFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}
