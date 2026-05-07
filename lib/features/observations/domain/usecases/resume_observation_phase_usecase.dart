import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class ResumeObservationPhaseUseCase {
  ResumeObservationPhaseUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(ObservationSession session) async {
    final now = DateTime.now();
    final endTime = session.endTime;

    if (endTime == null) {
      return const Err(ResumeSessionExpiredFailure());
    }

    final difference = now.difference(endTime).abs();

    if (difference > const Duration(days: 1)) {
      return const Err(ResumeSessionExpiredFailure());
    }

    final updated = session.copyWith(
      endTime: null,
      updatedAt: now,
    );

    return repository.updateSession(updated);
  }
}
