import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class StopObservationPhaseUseCase {
  StopObservationPhaseUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<ObservationSession>> call(ObservationSession session) async {
    final now = DateTime.now();
    final updated = session.copyWith(endTime: now, updatedAt: now);

    final result = await repository.updateSession(updated);

    return result.when(
      success: (_) => Ok(updated),
      failure: Err.new,
    );
  }
}
