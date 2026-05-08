import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/location_service.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class RetrySessionLocationUseCase {
  RetrySessionLocationUseCase({
    required this.repository,
    required this.locationService,
  });

  final ObservationRepository repository;
  final LocationService locationService;

  Future<Result<ObservationSession>> call(
    ObservationSession currentSession,
  ) async {
    if (currentSession.location != null &&
        currentSession.locationError == null) {
      return Ok(currentSession);
    }

    final result = await locationService.getLocation();

    return result.when(
      success: (pos) async {
        final updatedSession = currentSession.copyWith(
          location: pos,
          locationError: null,
          updatedAt: DateTime.now(),
        );
        await repository.updateSession(updatedSession);
        return Ok(updatedSession);
      },
      failure: (failure) async {
        var errorType = LocationErrorType.timeoutNoSignal;
        if (failure is PermissionDeniedFailure) {
          errorType = LocationErrorType.permissionDenied;
        } else if (failure is GpsDisabledFailure) {
          errorType = LocationErrorType.gpsDisabled;
        }

        if (currentSession.locationError != errorType) {
          final updatedSession = currentSession.copyWith(
            locationError: errorType,
            updatedAt: DateTime.now(),
          );
          await repository.updateSession(updatedSession);
          return Ok(updatedSession);
        }

        return Ok(currentSession);
      },
    );
  }
}
