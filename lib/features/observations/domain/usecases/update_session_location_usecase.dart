import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class UpdateSessionLocationUseCase {
  UpdateSessionLocationUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<Unit>> call({
    required String sessionId,
    GeoPosition? location,
    LocationErrorType? locationError,
  }) async {
    ObservationSession? session;
    final sessionResult = await repository.getSessionById(sessionId);
    if (sessionResult is Err<ObservationSession?>) {
      return Err(sessionResult.failure);
    } else if (sessionResult is Ok<ObservationSession?>) {
      session = sessionResult.value;
    }

    if (session == null) return const Err(SessionNotFoundFailure());

    final updatedSession = session.updateLocation(
      location: location,
      locationError: locationError,
    );

    return await repository.saveSession(updatedSession);
  }
}
