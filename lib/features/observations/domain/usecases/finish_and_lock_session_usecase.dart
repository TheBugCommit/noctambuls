import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class FinishAndLockSessionUseCase {
  FinishAndLockSessionUseCase(this.repository, this.censusRepository);

  final SessionRepository repository;
  final CensusRepository censusRepository;

  Future<Result<Unit>> call(ObservationSession session) async {
    final updated = session.finishAndLock();
    final saveResult = await repository.saveSession(updated);

    if (saveResult.isOk && session.isCensus && session.censusId != null) {
      final result = await censusRepository.getById(session.censusId!);
      await result.when(
        failure: (_) {},
        success: (census) async {
          if (census == null) return;
          await censusRepository.save(census.markAsDone());
        },
      );
    }

    return saveResult;
  }
}
