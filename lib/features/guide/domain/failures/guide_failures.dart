import 'package:noctambuls/core/error/failure.dart';

sealed class GuideFailure extends Failure {
  const GuideFailure({
    required super.debugMessage,
    required super.statusCode,
    super.stackTrace,
  });
}

final class GuideFetchFailure extends GuideFailure {
  const GuideFetchFailure({
    super.debugMessage = 'Failed to fetch birds',
    super.statusCode = 500,
    super.stackTrace,
  });

  @override
  GuideFetchFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      GuideFetchFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}
