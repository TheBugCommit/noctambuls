import 'package:noctambuls/core/domain/error/failure.dart';

sealed class CensusFailure extends Failure {
  const CensusFailure({
    required super.debugMessage,
    required super.statusCode,
    super.stackTrace,
  });
}

final class CensusNotFoundFailure extends CensusFailure {
  const CensusNotFoundFailure({
    super.debugMessage = 'Census could not be found',
    super.statusCode = 404,
    super.stackTrace,
  });

  @override
  CensusNotFoundFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      this;
}

final class InvalidCensusTokenFailure extends CensusFailure {
  const InvalidCensusTokenFailure({
    super.debugMessage = 'Census JWT token is invalid or malformed',
    super.statusCode = 400,
    super.stackTrace,
  });

  @override
  InvalidCensusTokenFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      InvalidCensusTokenFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class CensusSessionAlreadyFinishedFailure extends CensusFailure {
  const CensusSessionAlreadyFinishedFailure({
    super.debugMessage = 'The census session already done',
    super.statusCode = 409,
    super.stackTrace,
  });

  @override
  CensusSessionAlreadyFinishedFailure withDebug(
    Object error, [
    StackTrace? stackTrace,
  ]) => this;
}

final class CensusNotTodayFailure extends CensusFailure {
  const CensusNotTodayFailure({
    super.debugMessage = 'The census date is not today',
    super.statusCode = 409,
    super.stackTrace,
  });

  @override
  CensusNotTodayFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      this;
}

final class CensusJoinAlreadyHasLobbyFailure extends CensusFailure {
  const CensusJoinAlreadyHasLobbyFailure({
    super.debugMessage = 'Another census is already in lobby (isJoined=true)',
    super.statusCode = 409,
    super.stackTrace,
  });

  @override
  CensusJoinAlreadyHasLobbyFailure withDebug(
    Object error, [
    StackTrace? stackTrace,
  ]) => this;
}

final class CensusFetchFailure extends CensusFailure {
  const CensusFetchFailure({
    super.debugMessage = 'Could not fetch censuses from server',
    super.statusCode = 500,
    super.stackTrace,
  });

  @override
  CensusFetchFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      CensusFetchFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class CensusDatabaseFailure extends CensusFailure {
  const CensusDatabaseFailure({
    super.debugMessage = 'Census database operation failed',
    super.statusCode = 500,
    super.stackTrace,
  });

  @override
  CensusDatabaseFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      CensusDatabaseFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}
