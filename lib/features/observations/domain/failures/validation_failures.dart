import 'package:noctambuls/core/domain/error/failure.dart';

final class SessionValidationFailure extends Failure {
  const SessionValidationFailure({
    required this.missingSessionLocation,
    required this.missingObservationLocationIds,
    required this.missingListeningPoint,
    super.debugMessage = 'Validation failed before finalization',
    super.statusCode = 400,
  });

  final bool missingSessionLocation;
  final Set<String> missingObservationLocationIds;
  final bool missingListeningPoint;

  @override
  SessionValidationFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      this;
}
