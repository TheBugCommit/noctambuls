import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';

class UpdateAllObservationsDateUseCase {
  UpdateAllObservationsDateUseCase(this.repository);

  final ObservationRepository repository;

  Future<Result<Unit>> call(
    List<ObservationRecord> observations,
    DateTime newDate,
  ) async {
    final now = DateTime.now();

    for (final obs in observations) {
      var newStart = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        obs.startTime.hour,
        obs.startTime.minute,
      );

      var newEnd = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        obs.endTime.hour,
        obs.endTime.minute,
      );

      if (newStart.isAfter(now)) newStart = now;
      if (newEnd.isAfter(now)) newEnd = newStart;

      final updated = obs.copyWith(
        startTime: newStart,
        endTime: newEnd,
        updatedAt: now,
      );

      final result = await repository.updateObservation(updated);

      if (result.isErr) {
        return result;
      }
    }

    return const Ok(Unit.instance);
  }
}
