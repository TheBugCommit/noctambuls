import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:uuid/uuid.dart';

class SaveObservationUseCase {
  SaveObservationUseCase(this.repository);

  final ObservationRepository repository;

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
  }) async {
    final isEditing = existingRecord != null;
    final now = DateTime.now();

    final record = ObservationRecord(
      id: isEditing ? existingRecord.id : const Uuid().v4(),
      sessionId: sessionId,
      speciesId: speciesId,
      contactType: contactType,
      quantity: quantity,
      notes: notes,
      startTime: startTime,
      endTime: endTime,
      createdAt: isEditing ? existingRecord.createdAt : now,
      updatedAt: now,
      location: location,
      locationError: locationError,
      bearing: bearing,
      validationStatus:
          existingRecord?.validationStatus ?? ValidationStatus.pending,
      syncStatus: SyncStatus.draft,
    );

    Result<Unit> dbResult;
    if (isEditing) {
      dbResult = await repository.updateObservation(record);
    } else {
      dbResult = await repository.addObservation(record);
    }

    return dbResult.when(
      success: (_) => Ok(record),
      failure: Err.new,
    );
  }
}
