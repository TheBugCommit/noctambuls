import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/features/observations/data/datasources/session_local_datasource.dart';
import 'package:noctambuls/features/observations/data/models/observation_record_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';

class MockUserDatabaseManager extends Mock implements UserDatabaseManager {}

void main() {
  late UserDatabase db;
  late SessionLocalDataSourceImpl dataSource;
  late MockUserDatabaseManager mockDbManager;

  setUp(() {
    db = UserDatabase.forTesting(NativeDatabase.memory());
    mockDbManager = MockUserDatabaseManager();
    when(() => mockDbManager.database).thenReturn(db);
    dataSource = SessionLocalDataSourceImpl(dbManager: mockDbManager);
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
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
    isDeleted: false,
  );

  final tLockedSession = ObservationSessionModel(
    id: 'sess-locked',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    isLocked: true,
    syncStatus: SyncStatus.synced,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
    isDeleted: false,
  );

  final tObservationModel = ObservationRecordModel(
    id: 'obs-1',
    sessionId: 'sess-1',
    speciesId: 'bubo_bubo',
    contactType: ContactType.auditive,
    bearing: 0.0,
    quantity: 1,
    startTime: DateTime(2024),
    endTime: DateTime(2024),
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  group('save i getActiveSession', () {
    test(
      'hauria de guardar una sessió i recuperar-la com a sessió activa',
      () async {
        await dataSource.save(tSessionModel);

        final result = await dataSource.getActiveSession();

        expect(result, isNotNull);
        expect(result!.id, tSessionModel.id);
        expect(result.sessionType, tSessionModel.sessionType);
      },
    );

    test(
      'no hauria de retornar cap sessió activa si isLocked = true',
      () async {
        await dataSource.save(tLockedSession);

        final result = await dataSource.getActiveSession();

        expect(result, isNull);
      },
    );

    test(
      'getActiveSession hauria de retornar null si no hi ha sessions',
      () async {
        final result = await dataSource.getActiveSession();
        expect(result, isNull);
      },
    );

    test(
      'save hauria de guardar les observacions embegudes en la sessió',
      () async {
        final sessionWithObs = ObservationSessionModel(
          id: tSessionModel.id,
          annotatorId: tSessionModel.annotatorId,
          sessionType: tSessionModel.sessionType,
          isLocked: tSessionModel.isLocked,
          syncStatus: tSessionModel.syncStatus,
          createdAt: tSessionModel.createdAt,
          updatedAt: tSessionModel.updatedAt,
          isDeleted: tSessionModel.isDeleted,
          observations: [tObservationModel],
        );

        await dataSource.save(sessionWithObs);

        final retrieved = await dataSource.getById(tSessionModel.id);
        expect(retrieved, isNotNull);
        expect(retrieved!.observations.length, 1);
        expect(retrieved.observations.first.id, tObservationModel.id);
      },
    );

    test(
      'save (upsert) hauria de substituir les observacions prèvies',
      () async {
        final withOneObs = ObservationSessionModel(
          id: tSessionModel.id,
          annotatorId: tSessionModel.annotatorId,
          sessionType: tSessionModel.sessionType,
          isLocked: false,
          syncStatus: tSessionModel.syncStatus,
          createdAt: tSessionModel.createdAt,
          updatedAt: tSessionModel.updatedAt,
          isDeleted: false,
          observations: [tObservationModel],
        );

        await dataSource.save(withOneObs);

        final withNoObs = ObservationSessionModel(
          id: tSessionModel.id,
          annotatorId: tSessionModel.annotatorId,
          sessionType: tSessionModel.sessionType,
          isLocked: false,
          syncStatus: tSessionModel.syncStatus,
          createdAt: tSessionModel.createdAt,
          updatedAt: tSessionModel.updatedAt,
          isDeleted: false,
        );

        await dataSource.save(withNoObs);

        final retrieved = await dataSource.getById(tSessionModel.id);
        expect(retrieved!.observations, isEmpty);
      },
    );
  });

  group('delete i cascade', () {
    test(
      'delete hauria d\'eliminar la sessió i les seves observacions de la BD',
      () async {
        final sessionWithObs = ObservationSessionModel(
          id: tSessionModel.id,
          annotatorId: tSessionModel.annotatorId,
          sessionType: tSessionModel.sessionType,
          isLocked: false,
          syncStatus: tSessionModel.syncStatus,
          createdAt: tSessionModel.createdAt,
          updatedAt: tSessionModel.updatedAt,
          isDeleted: false,
          observations: [tObservationModel],
        );

        await dataSource.save(sessionWithObs);
        expect(await dataSource.getById(tSessionModel.id), isNotNull);

        await dataSource.delete(tSessionModel.id);

        expect(await dataSource.getById(tSessionModel.id), isNull);
        expect(await dataSource.getActiveSession(), isNull);
      },
    );
  });

  group('watchActiveSession', () {
    test(
      'hauria d\'emetre la sessió quan s\'afegeix una sessió activa',
      () async {
        final stream = dataSource.watchActiveSession();

        await dataSource.save(tSessionModel);

        await expectLater(
          stream,
          emitsThrough(
            predicate<ObservationSessionModel?>((s) => s?.id == tSessionModel.id),
          ),
        );
      },
    );

    test(
      'hauria d\'emetre null quan no hi ha sessió activa',
      () async {
        final stream = dataSource.watchActiveSession();

        await expectLater(stream, emits(isNull));
      },
    );
  });

  group('getPendingSessions', () {
    test(
      'hauria de retornar només sessions amb estat pending',
      () async {
        final draftSession = ObservationSessionModel(
          id: 'draft-1',
          annotatorId: 'user-1',
          sessionType: SessionType.incidental,
          isLocked: false,
          syncStatus: SyncStatus.draft,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
          isDeleted: false,
        );

        await dataSource.save(tSessionModel);
        await dataSource.save(draftSession);

        final result = await dataSource.getPendingSessions();

        expect(result.length, 1);
        expect(result.first.id, tSessionModel.id);
        expect(result.first.syncStatus, SyncStatus.pending);
      },
    );

    test(
      'hauria de retornar llista buida si no hi ha sessions pending',
      () async {
        final result = await dataSource.getPendingSessions();
        expect(result, isEmpty);
      },
    );
  });

  group('bulkUpsertSessions', () {
    test(
      'no hauria de sobreescriure sessions locals en estat pending',
      () async {
        await dataSource.save(tSessionModel);

        final remoteVersion = ObservationSessionModel(
          id: tSessionModel.id,
          annotatorId: tSessionModel.annotatorId,
          sessionType: SessionType.station,
          isLocked: false,
          syncStatus: SyncStatus.synced,
          createdAt: tSessionModel.createdAt,
          updatedAt: DateTime(2024, 6),
          isDeleted: false,
        );

        await dataSource.bulkUpsertSessions([remoteVersion]);

        final retrieved = await dataSource.getById(tSessionModel.id);
        expect(retrieved!.syncStatus, SyncStatus.pending);
        expect(retrieved.sessionType, SessionType.census);
      },
    );

    test(
      'hauria de sobreescriure sessions locals en estat synced',
      () async {
        final syncedSession = ObservationSessionModel(
          id: 'synced-1',
          annotatorId: 'user-1',
          sessionType: SessionType.incidental,
          isLocked: false,
          syncStatus: SyncStatus.synced,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
          isDeleted: false,
        );

        await dataSource.save(syncedSession);

        final updatedFromServer = ObservationSessionModel(
          id: 'synced-1',
          annotatorId: 'user-1',
          sessionType: SessionType.station,
          isLocked: true,
          syncStatus: SyncStatus.synced,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024, 6),
          isDeleted: false,
        );

        await dataSource.bulkUpsertSessions([updatedFromServer]);

        final retrieved = await dataSource.getById('synced-1');
        expect(retrieved!.sessionType, SessionType.station);
        expect(retrieved.isLocked, isTrue);
      },
    );

    test(
      'hauria de ser un no-op amb llista buida',
      () async {
        await dataSource.bulkUpsertSessions([]);
      },
    );
  });

  group('bulkUpdateSyncStatuses', () {
    test(
      'hauria d\'actualitzar l\'estat de sync de múltiples sessions',
      () async {
        final sess2 = ObservationSessionModel(
          id: 'sess-2',
          annotatorId: 'user-1',
          sessionType: SessionType.incidental,
          isLocked: false,
          syncStatus: SyncStatus.pending,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
          isDeleted: false,
        );

        await dataSource.save(tSessionModel);
        await dataSource.save(sess2);

        await dataSource.bulkUpdateSyncStatuses({
          'sess-1': (SyncStatus.synced, null),
          'sess-2': (SyncStatus.error, null),
        });

        final s1 = await dataSource.getById('sess-1');
        final s2 = await dataSource.getById('sess-2');
        expect(s1!.syncStatus, SyncStatus.synced);
        expect(s2!.syncStatus, SyncStatus.error);
      },
    );

    test('hauria de ser un no-op amb mapa buit', () async {
      await dataSource.bulkUpdateSyncStatuses({});
    });
  });

  group('saveSyncMetadata i getSyncMetadata', () {
    test(
      'hauria de persistir i recuperar les metadades de sincronització',
      () async {
        await dataSource.saveSyncMetadata(
          'history_since',
          since: '2024-01-01T00:00:00Z',
          currentPage: 2,
        );

        final result = await dataSource.getSyncMetadata('history_since');

        expect(result.since, '2024-01-01T00:00:00Z');
        expect(result.currentPage, 2);
      },
    );

    test(
      'hauria de retornar valors per defecte si la clau no existeix',
      () async {
        final result = await dataSource.getSyncMetadata('nonexistent');

        expect(result.since, isNull);
        expect(result.currentPage, 0);
      },
    );

    test(
      'hauria d\'actualitzar metadades existents (upsert)',
      () async {
        await dataSource.saveSyncMetadata('key', currentPage: 1);
        await dataSource.saveSyncMetadata('key', currentPage: 3);

        final result = await dataSource.getSyncMetadata('key');
        expect(result.currentPage, 3);
      },
    );
  });

  group('watchOwnSessions i watchParticipatedSessions', () {
    final tUser1Session = ObservationSessionModel(
      id: 'own-1',
      annotatorId: 'user-1',
      sessionType: SessionType.incidental,
      isLocked: false,
      syncStatus: SyncStatus.synced,
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
      isDeleted: false,
    );

    final tUser2Session = ObservationSessionModel(
      id: 'other-1',
      annotatorId: 'user-2',
      sessionType: SessionType.census,
      isLocked: false,
      syncStatus: SyncStatus.synced,
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
      isDeleted: false,
    );

    test(
      'watchOwnSessions hauria de retornar sessions de l\'usuari indicat',
      () async {
        await dataSource.save(tUser1Session);
        await dataSource.save(tUser2Session);

        final result = await dataSource.watchOwnSessions('user-1').first;

        expect(result.length, 1);
        expect(result.first.id, 'own-1');
      },
    );

    test(
      'watchParticipatedSessions hauria de retornar sessions d\'altres usuaris',
      () async {
        await dataSource.save(tUser1Session);
        await dataSource.save(tUser2Session);

        final result =
            await dataSource.watchParticipatedSessions('user-1').first;

        expect(result.length, 1);
        expect(result.first.id, 'other-1');
      },
    );

    test(
      'watchOwnSessions hauria de retornar llista buida si no hi ha sessions pròpies',
      () async {
        final result = await dataSource.watchOwnSessions('user-1').first;
        expect(result, isEmpty);
      },
    );
  });
}
