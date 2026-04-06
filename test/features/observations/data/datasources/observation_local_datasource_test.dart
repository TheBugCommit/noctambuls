import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/features/observations/data/datasources/observation_local_datasource.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';

void main() {
  late AppDatabase db;
  late ObservationLocalDataSourceImpl dataSource;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dataSource = ObservationLocalDataSourceImpl(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  final tSessionModel = ObservationSessionModel(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    isLocked: false,
    syncStatus: SyncStatus.pending,
    createdAt: DateTime(2023),
    updatedAt: DateTime(2023),
    isDeleted: false,
  );

  final tObservationModel = ObservationRecordModel(
    id: 'obs-1',
    sessionId: 'sess-1',
    speciesId: 'bubo_bubo',
    contactType: 'auditory',
    quantity: 1,
    startTime: DateTime(2023),
    endTime: DateTime(2023),
    createdAt: DateTime(2023),
    updatedAt: DateTime(2023),
  );

  group('Crear i Obtenir Sessions', () {
    test(
      'hauria de guardar una sessió i recuperar-la com a "sessió activa"',
      () async {
        await dataSource.createSession(tSessionModel);

        final result = await dataSource.getActiveSession();

        expect(result, isNotNull);
        expect(result?.id, tSessionModel.id);
        expect(result?.sessionType, tSessionModel.sessionType);
      },
    );

    test(
      'no hauria de retornar cap sessió activa si està bloquejada (isLocked = true)',
      () async {
        final lockedSession = ObservationSessionModel(
          id: 'sess-2',
          annotatorId: 'user-1',
          sessionType: SessionType.incidental,
          isLocked: true,
          syncStatus: SyncStatus.pending,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isDeleted: false,
        );

        await dataSource.createSession(lockedSession);
        final result = await dataSource.getActiveSession();

        expect(result, isNull);
      },
    );
  });

  group('Integració i Esborrat en Cascada (Soft Delete)', () {
    test(
      'esborrar una sessió hauria de marcar també les seves observacions com a eliminades',
      () async {
        await dataSource.createSession(tSessionModel);
        await dataSource.addObservation(tObservationModel);

        final initialObservations = await dataSource
            .watchObservationsForSession(tSessionModel.id)
            .first;
        expect(initialObservations.length, 1);

        await dataSource.deleteSession(tSessionModel.id);

        final activeSession = await dataSource.getActiveSession();
        expect(activeSession, isNull);

        final finalObservations = await dataSource
            .watchObservationsForSession(tSessionModel.id)
            .first;
        expect(finalObservations.length, 0);
      },
    );
  });
}
