import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/data/datasources/census_local_datasource.dart';
import 'package:noctambuls/features/censuses/data/datasources/census_remote_datasource.dart';
import 'package:noctambuls/features/censuses/data/models/api/censuses_response_model.dart';
import 'package:noctambuls/features/censuses/data/models/census_model.dart';
import 'package:noctambuls/features/censuses/data/repositories/census_repository_impl.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';

class MockCensusLocalDataSource extends Mock implements CensusLocalDataSource {}

class MockCensusRemoteDataSource extends Mock
    implements CensusRemoteDataSource {}

class FakeCensusModel extends Fake implements CensusModel {}

void main() {
  late MockCensusLocalDataSource mockLocal;
  late MockCensusRemoteDataSource mockRemote;
  late CensusRepositoryImpl repository;

  final tNow = DateTime(2024, 6, 15, 20).toUtc();
  final tServerTime = '2024-06-15T20:00:00.000Z';

  final tModel = CensusModel(
    id: 'c1',
    title: 'Cens Test',
    startTime: tNow,
    createdAt: tNow,
    updatedAt: tNow,
  );

  final tDeletedModel = CensusModel(
    id: 'c2',
    title: 'Cens Eliminat',
    startTime: tNow,
    createdAt: tNow,
    updatedAt: tNow,
    isDeleted: true,
  );

  setUpAll(() {
    registerFallbackValue(FakeCensusModel());
    registerFallbackValue(<CensusModel>[]);
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    mockLocal = MockCensusLocalDataSource();
    mockRemote = MockCensusRemoteDataSource();
    repository = CensusRepositoryImpl(
      localDataSource: mockLocal,
      remoteDataSource: mockRemote,
    );
  });

  group('watchAll', () {
    test('mapeja stream local CensusModel→Census', () {
      when(() => mockLocal.watchAll())
          .thenAnswer((_) => Stream.value([tModel]));

      final stream = repository.watchAll();

      expect(
        stream,
        emits(
          isA<List<Census>>().having((l) => l.first.id, 'id', 'c1'),
        ),
      );
    });
  });

  group('watchJoinedCensus', () {
    test('mapeja model a domain', () {
      final joinedModel = CensusModel(
        id: 'c1',
        title: 'Cens',
        startTime: tNow,
        createdAt: tNow,
        updatedAt: tNow,
        isJoined: true,
      );
      when(() => mockLocal.watchJoinedCensus())
          .thenAnswer((_) => Stream.value(joinedModel));

      final stream = repository.watchJoinedCensus();

      expect(
        stream,
        emits(isA<Census>().having((c) => c.id, 'id', 'c1')),
      );
    });

    test('mapeja null quan no hi ha cens unit', () {
      when(() => mockLocal.watchJoinedCensus())
          .thenAnswer((_) => Stream.value(null));

      expect(repository.watchJoinedCensus(), emits(isNull));
    });
  });

  group('getById', () {
    test('cens trobat → Ok(census)', () async {
      when(() => mockLocal.getById('c1')).thenAnswer((_) async => tModel);

      final result = await repository.getById('c1');

      expect(result, isA<Ok<Census?>>());
      expect((result as Ok<Census?>).value?.id, 'c1');
    });

    test('cens no trobat → Ok(null)', () async {
      when(() => mockLocal.getById('c1')).thenAnswer((_) async => null);

      final result = await repository.getById('c1');

      expect(result, isA<Ok<Census?>>());
      expect((result as Ok<Census?>).value, isNull);
    });

    test('llença excepció → Err(CensusDatabaseFailure)', () async {
      when(() => mockLocal.getById('c1')).thenThrow(Exception('DB error'));

      final result = await repository.getById('c1');

      expect(result, isA<Err<Census?>>());
      expect((result as Err<Census?>).failure, isA<CensusDatabaseFailure>());
    });
  });

  group('getJoinedCensus', () {
    test('cens trobat → Ok(census)', () async {
      when(() => mockLocal.getJoinedCensus()).thenAnswer((_) async => tModel);

      final result = await repository.getJoinedCensus();

      expect(result, isA<Ok<Census?>>());
    });

    test('null → Ok(null)', () async {
      when(() => mockLocal.getJoinedCensus()).thenAnswer((_) async => null);

      final result = await repository.getJoinedCensus();

      expect((result as Ok<Census?>).value, isNull);
    });

    test('excepció → Err(CensusDatabaseFailure)', () async {
      when(() => mockLocal.getJoinedCensus()).thenThrow(Exception('DB error'));

      final result = await repository.getJoinedCensus();

      expect(result, isA<Err<Census?>>());
    });
  });

  group('save', () {
    test('èxit → Ok(Unit)', () async {
      when(() => mockLocal.save(any())).thenAnswer((_) async {});

      final census = tModel.toDomain();
      final result = await repository.save(census);

      expect(result, isA<Ok<Unit>>());
    });

    test('llença excepció → Err(CensusDatabaseFailure)', () async {
      when(() => mockLocal.save(any())).thenThrow(Exception('DB error'));

      final result = await repository.save(tModel.toDomain());

      expect(result, isA<Err<Unit>>());
      expect((result as Err<Unit>).failure, isA<CensusDatabaseFailure>());
    });
  });

  group('fetchAndSync', () {
    final tResponse = CensusesResponseModel(
      censuses: [
        CensusRemoteDto(
          id: 'c1',
          title: 'Cens Test',
          date: '2024-06-15',
          time: '20:00',
          updatedAt: '2024-06-15T18:00:00.000Z',
        ),
      ],
      serverTime: tServerTime,
    );

    final tResponseWithDelete = CensusesResponseModel(
      censuses: [
        CensusRemoteDto(
          id: 'c1',
          title: 'Cens Test',
          date: '2024-06-15',
          time: '20:00',
          updatedAt: '2024-06-15T18:00:00.000Z',
        ),
        CensusRemoteDto(
          id: 'c2',
          title: 'Eliminat',
          date: '2024-06-15',
          time: '20:00',
          updatedAt: '2024-06-15T18:00:00.000Z',
          isDeleted: true,
        ),
      ],
      serverTime: tServerTime,
    );

    setUp(() {
      when(() => mockLocal.delete(any())).thenAnswer((_) async {});
      when(() => mockLocal.bulkUpsert(any())).thenAnswer((_) async {});
      when(() => mockLocal.saveSyncMetadata(any(), since: any(named: 'since')))
          .thenAnswer((_) async {});
    });

    test('primera sync (sense since) → crida fetchCensuses(since: null)', () async {
      when(() => mockLocal.getSyncSince('censuses_since'))
          .thenAnswer((_) async => null);
      when(() => mockRemote.fetchCensuses(since: null))
          .thenAnswer((_) async => tResponse);

      final result = await repository.fetchAndSync();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockRemote.fetchCensuses(since: null)).called(1);
    });

    test('sync incremental → passa since al remote', () async {
      const tSince = '2024-06-14T00:00:00.000Z';
      when(() => mockLocal.getSyncSince('censuses_since'))
          .thenAnswer((_) async => tSince);
      when(() => mockRemote.fetchCensuses(since: tSince))
          .thenAnswer((_) async => tResponse);

      await repository.fetchAndSync();

      verify(() => mockRemote.fetchCensuses(since: tSince)).called(1);
    });

    test(
      'separa isDeleted=true (delete) i isDeleted=false (upsert) correctament',
      () async {
        when(() => mockLocal.getSyncSince(any())).thenAnswer((_) async => null);
        when(() => mockRemote.fetchCensuses(since: any(named: 'since')))
            .thenAnswer((_) async => tResponseWithDelete);

        await repository.fetchAndSync();

        final deletedIds =
            verify(() => mockLocal.delete(captureAny())).captured.single as List<String>;
        expect(deletedIds, ['c2']);

        final upserted =
            verify(() => mockLocal.bulkUpsert(captureAny())).captured.single
                as List<CensusModel>;
        expect(upserted.length, 1);
        expect(upserted.first.id, 'c1');
      },
    );

    test('guarda serverTime com a nou since', () async {
      when(() => mockLocal.getSyncSince(any())).thenAnswer((_) async => null);
      when(() => mockRemote.fetchCensuses(since: any(named: 'since')))
          .thenAnswer((_) async => tResponse);

      await repository.fetchAndSync();

      verify(
        () => mockLocal.saveSyncMetadata(
          'censuses_since',
          since: tServerTime,
        ),
      ).called(1);
    });

    test('DioException → Err(CensusFetchFailure)', () async {
      when(() => mockLocal.getSyncSince(any())).thenAnswer((_) async => null);
      when(() => mockRemote.fetchCensuses(since: any(named: 'since')))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      final result = await repository.fetchAndSync();

      expect(result, isA<Err<Unit>>());
      expect((result as Err<Unit>).failure, isA<CensusFetchFailure>());
    });

    test('excepció local → Err(CensusDatabaseFailure)', () async {
      when(() => mockLocal.getSyncSince(any())).thenAnswer((_) async => null);
      when(() => mockRemote.fetchCensuses(since: any(named: 'since')))
          .thenAnswer((_) async => tResponse);
      when(() => mockLocal.bulkUpsert(any())).thenThrow(Exception('DB error'));

      final result = await repository.fetchAndSync();

      expect(result, isA<Err<Unit>>());
      expect((result as Err<Unit>).failure, isA<CensusDatabaseFailure>());
    });
  });
}
