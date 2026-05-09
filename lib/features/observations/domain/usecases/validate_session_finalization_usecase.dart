import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/failures/validation_failures.dart';

class ValidateSessionFinalizationUseCase {
  Result<Unit> call({
    required ObservationSession session,
    required List<ObservationRecord> observations,
  }) {
    var missingSessionLocation = false;
    var missingObsLocations = <String>{};
    var missingListeningPoint = false;

    if (session.needsListeningPoint && session.listeningPoint == null) {
      missingListeningPoint = true;
    }

    if (session.isIncidental) {
      missingObsLocations = observations
          .where((o) => o.location == null)
          .map((o) => o.id)
          .toSet();
    } else {
      if (session.location == null) {
        missingSessionLocation = true;
      }
    }

    if (missingSessionLocation ||
        missingObsLocations.isNotEmpty ||
        missingListeningPoint) {
      return Err(
        SessionValidationFailure(
          missingSessionLocation: missingSessionLocation,
          missingObservationLocationIds: missingObsLocations,
          missingListeningPoint: missingListeningPoint,
        ),
      );
    }

    return const Ok(Unit.instance);
  }
}
