import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:uuid/uuid.dart';

class CreateSessionUseCase {
  CreateSessionUseCase({
    required this.observationRepository,
    required this.locationService,
  });

  final ObservationRepository observationRepository;
  final LocationService locationService;

  Future<Result<Unit>> call(SessionType sessionType, String annotatorId) async {
    final activeSessionResult = await observationRepository.getActiveSession();
    return activeSessionResult.when(
      failure: Err.new,
      success: (activeSession) async {
        if (activeSession != null) {
          return const Err(ActiveSessionAlreadyExistsFailure());
        }

        final newSession = await _createImmediateSession(
          sessionType,
          annotatorId,
        );

        final saveResult = await observationRepository.createSession(
          newSession,
        );

        if (saveResult.isOk && _needsFreshLocation(sessionType, newSession)) {
          _fetchAndUpdateLocationInBackground(newSession);
        }

        return saveResult;
      },
    );
  }

  Future<ObservationSession> _createImmediateSession(
    SessionType sessionType,
    String userId,
  ) async {
    double? startLat;
    double? startLng;

    if (sessionType == SessionType.census ||
        sessionType == SessionType.station) {
      final lastKnownResult = await locationService.getLastKnownLocation();

      lastKnownResult.when(
        failure: (_) {},
        success: (pos) {
          startLat = pos.latitude;
          startLng = pos.longitude;
        },
      );
    }

    final now = DateTime.now();

    return ObservationSession(
      id: const Uuid().v4(),
      annotatorId: userId,
      sessionType: sessionType,
      startTime: now,
      latitude: startLat,
      longitude: startLng,
      createdAt: now,
      updatedAt: now,
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
        final updatedSession = session.copyWith(
          latitude: pos.latitude,
          longitude: pos.longitude,
          updatedAt: DateTime.now(),
        );

        await observationRepository.updateSession(updatedSession);
      },
      failure: (failure) {},
    );
  }
}
