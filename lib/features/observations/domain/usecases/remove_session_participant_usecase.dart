import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class RemoveSessionParticipantUseCase {
  RemoveSessionParticipantUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<ObservationSession>> call(
    ObservationSession session,
    String ornithologistCode,
  ) async {
    if (!session.participants.contains(ornithologistCode)) {
      return Ok(session);
    }

    final updatedParticipants = List<String>.from(session.participants)
      ..remove(ornithologistCode);

    final updatedSession = session.copyWith(
      participants: updatedParticipants,
      updatedAt: DateTime.now(),
    );

    final result = await repository.updateSession(updatedSession);

    return result.when(
      success: (_) => Ok(updatedSession),
      failure: Err.new,
    );
  }
}
