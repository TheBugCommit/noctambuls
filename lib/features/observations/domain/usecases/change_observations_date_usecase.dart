import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class ChangeObservationDateUseCase {
  ChangeObservationDateUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<ObservationSession>> call(
    ObservationSession session,
    DateTime newDate,
  ) async {
    final oldStart = session.startTime;

    final newStartTime = oldStart != null
        ? DateTime(
            newDate.year,
            newDate.month,
            newDate.day,
            oldStart.hour,
            oldStart.minute,
          )
        : DateTime(newDate.year, newDate.month, newDate.day);

    final updatedSession = session.copyWith(
      startTime: newStartTime,
      updatedAt: DateTime.now(),
    );

    final result = await repository.updateSession(updatedSession);

    return result.when(
      success: (_) => Ok(updatedSession),
      failure: Err.new,
    );
  }
}
