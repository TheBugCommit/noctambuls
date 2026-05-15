import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:uuid/uuid.dart';

class CreateSessionUseCase {
  CreateSessionUseCase({
    required this.sessionRepository,
    required this.locationService,
  });

  final SessionRepository sessionRepository;
  final LocationService locationService;

  Future<Result<Unit>> call(
    SessionType sessionType,
    String annotatorId, {
    String? censusId,
  }) async {
    final activeSessionResult = await sessionRepository.getActiveSession();
    return activeSessionResult.when(
      failure: Err.new,
      success: (activeSession) async {
        if (activeSession != null) {
          return const Err(ActiveSessionAlreadyExistsFailure());
        }

        if (censusId != null) {
          final censusSession = await sessionRepository.getSessionByCensusId(
            censusId,
          );

          if (censusSession is Ok<ObservationSession?> &&
              censusSession.value != null) {
            return const Err(AlreadyCensusSessionCreatedFailure());
          }
        }

        final newSession = await _createImmediateSession(
          sessionType,
          annotatorId,
          censusId: censusId,
        );

        final saveResult = await sessionRepository.saveSession(newSession);

        if (saveResult.isOk && _needsFreshLocation(sessionType, newSession)) {
          _fetchAndUpdateLocationInBackground(newSession);
        }

        return saveResult;
      },
    );
  }

  Future<ObservationSession> _createImmediateSession(
    SessionType sessionType,
    String userId, {
    String? censusId,
  }) async {
    GeoPosition? lastLocation;

    if (sessionType == SessionType.census ||
        sessionType == SessionType.station) {
      final lastKnownResult = await locationService.getLastKnownLocation();

      lastKnownResult.when(
        failure: (_) {},
        success: (pos) {
          lastLocation = pos;
        },
      );
    }

    final now = DateTime.now().toUtc();

    return ObservationSession(
      id: const Uuid().v4(),
      annotatorId: userId,
      sessionType: sessionType,
      location: lastLocation,
      startTime: now,
      createdAt: now,
      updatedAt: now,
      censusId: censusId,
    );
  }

  bool _needsFreshLocation(SessionType type, ObservationSession session) {
    if (type != SessionType.census && type != SessionType.station) return false;
    return true;
  }

  Future<void> _fetchAndUpdateLocationInBackground(
    ObservationSession session,
  ) async {
    final freshResult = await locationService.getLocation();

    await freshResult.when(
      success: (pos) async {
        final updatedSession = session.updateLocation(location: pos);
        await sessionRepository.saveSession(updatedSession);
      },
      failure: (failure) async {
        var errorType = LocationErrorType.timeoutNoSignal;
        if (failure is PermissionDeniedFailure) {
          errorType = LocationErrorType.permissionDenied;
        } else if (failure is GpsDisabledFailure) {
          errorType = LocationErrorType.gpsDisabled;
        }

        final failedSession = session.updateLocation(
          location: session.location,
          locationError: errorType,
        );

        await sessionRepository.saveSession(failedSession);
      },
    );
  }
}
