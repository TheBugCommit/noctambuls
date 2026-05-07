import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class FinishAndLockSessionUseCase {
  FinishAndLockSessionUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(ObservationSession session) async {
    if (!session.isFinished) {
      final updated = session.copyWith(
        isLocked: true,
        syncStatus: SyncStatus.pending,
        updatedAt: DateTime.now(),
      );

      return repository.updateSession(updated);
    }

    return const Ok(Unit.instance);
  }
}
