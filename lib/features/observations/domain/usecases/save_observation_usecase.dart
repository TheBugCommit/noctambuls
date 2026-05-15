import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/exceptions/session_exceptions.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:uuid/uuid.dart';

class SaveObservationUseCase {
  SaveObservationUseCase(this.repository);

  final SessionRepository repository;

  Future<Result<ObservationRecord>> call({
    required String sessionId,
    required String speciesId,
    required ContactType contactType,
    required int quantity,
    required double bearing,
    required DateTime startTime,
    required DateTime endTime,
    GeoPosition? location,
    LocationErrorType? locationError,
    String? notes,
    ObservationRecord? existingRecord,
    DateTime? newGlobalDate,
  }) async {
    ObservationSession? session;
    final sessionResult = await repository.getSessionById(sessionId);
    if (sessionResult is Err<ObservationSession?>) {
      return Err(sessionResult.failure);
    } else if (sessionResult is Ok<ObservationSession?>) {
      session = sessionResult.value;
    }

    if (session == null) {
      return const Err(SessionNotFoundFailure());
    }

    final isEditing = existingRecord != null;
    final now = DateTime.now().toUtc();

    final record = ObservationRecord(
      id: isEditing ? existingRecord.id : const Uuid().v4(),
      sessionId: sessionId,
      speciesId: speciesId,
      contactType: contactType,
      quantity: quantity,
      notes: notes,
      startTime: startTime.toUtc(),
      endTime: endTime.toUtc(),
      createdAt: isEditing ? existingRecord.createdAt : now,
      updatedAt: now,
      location: location,
      locationError: locationError,
      bearing: bearing,
    );

    try {
      var workingSession = session;
      if (newGlobalDate != null) {
        workingSession = workingSession.changeDate(newGlobalDate);
      }

      final ObservationSession updatedSession;

      updatedSession = isEditing
          ? workingSession.updateObservation(record)
          : workingSession.addObservation(record);

      final dbResult = await repository.saveSession(updatedSession);

      return dbResult.when(
        success: (_) => Ok(record),
        failure: Err.new,
      );
    } on SessionUpdateException {
      return const Err(SessionLockedFailure());
    } on ObservationMissingLocationException {
      return const Err(ObservationMissingLocationFailure());
    }
  }
}
