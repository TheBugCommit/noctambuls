import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class GetActiveSessionUseCase {
  GetActiveSessionUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<ObservationSession?>> call() => repository.getActiveSession();
}
