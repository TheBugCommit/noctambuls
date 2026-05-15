import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/exceptions/session_exceptions.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class StopObservationPhaseUseCase {
  StopObservationPhaseUseCase(this.repository, this.censusRepository);

  final SessionRepository repository;
  final CensusRepository censusRepository;

  Future<Result<ObservationSession>> call(ObservationSession session) async {
    try {
      final updatedSession = session.finishSession();
      final result = await repository.saveSession(updatedSession);

      if (result.isOk && session.isCensus && session.censusId != null) {
        final result = await censusRepository.getById(session.censusId!);
        await result.when(
          failure: (_) {},
          success: (census) async {
            if (census == null) return;
            await censusRepository.save(census.abandon());
          },
        );
      }

      return result.when(
        success: (_) => Ok(updatedSession),
        failure: Err.new,
      );
    } on SessionUpdateException catch (_) {
      return const Err(SessionLockedFailure());
    }
  }
}
