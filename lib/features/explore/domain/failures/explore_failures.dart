import 'package:noctambuls/core/domain/error/failure.dart';

sealed class ExploreFailure extends Failure {
  const ExploreFailure({
    required super.debugMessage,
    required super.statusCode,
    super.stackTrace,
  });
}

final class ExploreFetchFailure extends ExploreFailure {
  const ExploreFetchFailure({
    super.debugMessage = 'Could not fetch map bubbles from server',
    super.statusCode = 500,
    super.stackTrace,
  });

  @override
  ExploreFetchFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      ExploreFetchFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class ExploreDatabaseFailure extends ExploreFailure {
  const ExploreDatabaseFailure({
    super.debugMessage = 'Explore database operation failed',
    super.statusCode = 500,
    super.stackTrace,
  });

  @override
  ExploreDatabaseFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      ExploreDatabaseFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}
