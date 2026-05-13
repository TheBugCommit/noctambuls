import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';
import 'package:noctambuls/features/observations/domain/exceptions/session_exceptions.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class UpdateSessionPropertiesUseCase {
  UpdateSessionPropertiesUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<ObservationSession>> call({
    required String sessionId,
    TemperatureRange? temperature,
    WindLevel? wind,
    SkyCondition? sky,
    RainLevel? rain,
    VisibilityLevel? visibility,
    MoonPresence? moon,
    int? listeningPoint,
    GeoPosition? location,
  }) async {
    ObservationSession? session;
    final sessionResult = await repository.getSessionById(sessionId);

    if (sessionResult is Err<ObservationSession?>) {
      return Err(sessionResult.failure);
    } else if (sessionResult is Ok<ObservationSession?>) {
      session = sessionResult.value;
    }

    if (session == null) return const Err(SessionNotFoundFailure());

    try {
      var updatedSession = session.updateProperties(
        temperature: temperature,
        wind: wind,
        sky: sky,
        rain: rain,
        visibility: visibility,
        moon: moon,
        listeningPoint: listeningPoint,
      );

      updatedSession = updatedSession.updateLocation(
        location: location,
        locationError: null,
      );

      final result = await repository.saveSession(updatedSession);

      if (result is Err<Unit>) {
        return Err(result.failure);
      } else {
        return Ok(updatedSession);
      }
    } on SessionUpdateException catch (_) {
      return const Err(SessionLockedFailure());
    }
  }
}
