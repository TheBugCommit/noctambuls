import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_local_datasource.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_remote_datasource.dart';
import 'package:noctambuls/features/guide/data/models/bird_model.dart';
import 'package:noctambuls/features/guide/data/models/bird_remote_model.dart';
import 'package:noctambuls/features/guide/data/models/catalog_version_model.dart';
import 'package:noctambuls/features/guide/data/repositories/birds_repository_impl.dart';
import 'package:noctambuls/features/guide/data/services/catalog_media_service.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';

class MockBirdsLocalDataSource extends Mock implements BirdsLocalDataSource {}

class MockBirdsRemoteDataSource extends Mock implements BirdsRemoteDataSource {}

class MockCatalogMediaService extends Mock implements CatalogMediaService {}

class MockIAppLogger extends Mock implements IAppLogger {}

class FakeFailure extends Fake implements Failure {}

class FakeBirdEntityData extends Fake implements BirdEntityData {}

class FakeBirdNameEntityData extends Fake implements BirdNameEntityData {}

void main() {
  late MockBirdsLocalDataSource mockLocal;
  late MockBirdsRemoteDataSource mockRemote;
  late MockCatalogMediaService mockMedia;
  late MockIAppLogger mockLogger;
  late BirdsRepositoryImpl repository;

  const tModel = BirdModel(
    id: 'b1',
    commonName: 'Merla',
    scientificName: 'Turdus merula',
    description: 'Ocell comú',
    imageUrl: 'https://example.com/img.jpg',
    audioUrl: 'https://example.com/audio.mp3',
    infoUrl: 'https://example.com/info',
    localImagePath: '/local/img.jpg',
    localAudioPath: '/local/audio.mp3',
  );

  final tRemoteBird = BirdRemoteModel(
    id: 'b1',
    scientificName: 'Turdus merula',
    imagePath: '/images/b1.jpg',
    audioPath: '/audio/b1.mp3',
    translations: const [
      BirdNameRemoteModel(
        id: 'b1_ca',
        birdId: 'b1',
        languageCode: 'ca',
        commonName: 'Merla',
        description: 'Ocell comú',
      ),
    ],
  );

  final tRemoteVersionModel = CatalogVersionModel(
    version: 'v2',
    lastUpdatedAt: DateTime.utc(2024, 6, 15),
  );

  setUpAll(() {
    registerFallbackValue(FakeFailure());
    registerFallbackValue(FakeBirdEntityData());
    registerFallbackValue(FakeBirdNameEntityData());
    registerFallbackValue(<BirdEntityData>[]);
    registerFallbackValue(<BirdNameEntityData>[]);
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    mockLocal = MockBirdsLocalDataSource();
    mockRemote = MockBirdsRemoteDataSource();
    mockMedia = MockCatalogMediaService();
    mockLogger = MockIAppLogger();
    repository = BirdsRepositoryImpl(
      localDataSource: mockLocal,
      remoteDataSource: mockRemote,
      mediaService: mockMedia,
      logger: mockLogger,
    );

    when(() => mockMedia.getAbsolutePath(any()))
        .thenAnswer((i) async => '/abs/${i.positionalArguments.first}');
  });

  group('getBirds', () {
    test('local retorna models → Ok(List<Bird>) mapeats', () async {
      when(() => mockLocal.getBirds('ca')).thenAnswer((_) async => [tModel]);

      final result = await repository.getBirds('ca');

      expect(result, isA<Ok<List<Bird>>>());
      expect((result as Ok<List<Bird>>).value.first.id, 'b1');
    });

    test('excepció local → Err(DatabaseFailure)', () async {
      when(() => mockLocal.getBirds('ca')).thenThrow(Exception('DB error'));

      final result = await repository.getBirds('ca');

      expect(result, isA<Err<List<Bird>>>());
      expect((result as Err<List<Bird>>).failure, isA<DatabaseFailure>());
    });
  });

  group('getLocalVersion', () {
    test("local retorna 'v1' → Ok('v1')", () async {
      when(() => mockLocal.getCatalogVersion()).thenAnswer((_) async => 'v1');

      final result = await repository.getLocalVersion();

      expect(result, isA<Ok<String?>>());
      expect((result as Ok<String?>).value, 'v1');
    });

    test('local retorna null → Ok(null)', () async {
      when(() => mockLocal.getCatalogVersion()).thenAnswer((_) async => null);

      final result = await repository.getLocalVersion();

      expect((result as Ok<String?>).value, isNull);
    });

    test('excepció → Err(DatabaseFailure)', () async {
      when(() => mockLocal.getCatalogVersion()).thenThrow(Exception('DB error'));

      final result = await repository.getLocalVersion();

      expect(result, isA<Err<String?>>());
      expect((result as Err<String?>).failure, isA<DatabaseFailure>());
    });
  });

  group('getRemoteVersion', () {
    test("remote retorna versió → Ok('v2')", () async {
      when(() => mockRemote.getCatalogVersion())
          .thenAnswer((_) async => tRemoteVersionModel);

      final result = await repository.getRemoteVersion();

      expect(result, isA<Ok<String>>());
      expect((result as Ok<String>).value, 'v2');
    });

    test('excepció → Err(NetworkFailure) i loga failure', () async {
      when(() => mockRemote.getCatalogVersion()).thenThrow(Exception('xarxa'));
      when(() => mockLogger.failure(any())).thenReturn(null);

      final result = await repository.getRemoteVersion();

      expect(result, isA<Err<String>>());
      expect((result as Err<String>).failure, isA<NetworkFailure>());
      verify(() => mockLogger.failure(any())).called(1);
    });
  });

  group('downloadAndSaveCatalog', () {
    void stubHappyPath({bool mediaFails = false}) {
      when(() => mockRemote.getBirdsCatalog())
          .thenAnswer((_) async => [tRemoteBird]);
      when(() => mockLocal.getCatalogVersion()).thenAnswer((_) async => 'v1');
      when(() => mockRemote.getCatalogVersion())
          .thenAnswer((_) async => tRemoteVersionModel);
      when(() => mockMedia.ensureImage(any()))
          .thenAnswer((_) async => mediaFails ? null : '/local/img.jpg');
      when(() => mockMedia.ensureAudio(any()))
          .thenAnswer((_) async => mediaFails ? null : '/local/audio.mp3');
      when(() => mockLocal.saveFullCatalogTransaction(any(), any(), any()))
          .thenAnswer((_) async {});
      when(() => mockLocal.getAllLocalImagePaths())
          .thenAnswer((_) async => ['/local/img.jpg']);
      when(() => mockLocal.getAllLocalAudioPaths())
          .thenAnswer((_) async => ['/local/audio.mp3']);
      when(
        () => mockMedia.cleanOrphanedFiles(
          validImagePaths: any(named: 'validImagePaths'),
          validAudioPaths: any(named: 'validAudioPaths'),
        ),
      ).thenAnswer((_) async {});
      if (mediaFails) {
        when(() => mockLogger.warning(any())).thenReturn(null);
      }
    }

    test('tot OK → guarda versió remota i retorna Ok(Unit)', () async {
      stubHappyPath();

      final result = await repository.downloadAndSaveCatalog();

      expect(result, isA<Ok<Unit>>());
      final captured = verify(
        () => mockLocal.saveFullCatalogTransaction(any(), any(), captureAny()),
      ).captured;
      expect(captured.single, 'v2');
    });

    test('error de media → guarda versió local (no la remota)', () async {
      stubHappyPath(mediaFails: true);

      final result = await repository.downloadAndSaveCatalog();

      expect(result, isA<Ok<Unit>>());
      final captured = verify(
        () => mockLocal.saveFullCatalogTransaction(any(), any(), captureAny()),
      ).captured;
      expect(captured.single, 'v1');
    });

    test("excepció en getBirdsCatalog → Err(CatalogSyncFailure)", () async {
      when(() => mockRemote.getBirdsCatalog()).thenThrow(Exception('xarxa'));
      when(() => mockLogger.failure(any())).thenReturn(null);

      final result = await repository.downloadAndSaveCatalog();

      expect(result, isA<Err<Unit>>());
      expect((result as Err<Unit>).failure, isA<CatalogSyncFailure>());
    });

    test('cleanup llença excepció → loga warning i retorna Ok(Unit)', () async {
      when(() => mockRemote.getBirdsCatalog())
          .thenAnswer((_) async => [tRemoteBird]);
      when(() => mockLocal.getCatalogVersion()).thenAnswer((_) async => 'v1');
      when(() => mockRemote.getCatalogVersion())
          .thenAnswer((_) async => tRemoteVersionModel);
      when(() => mockMedia.ensureImage(any()))
          .thenAnswer((_) async => '/local/img.jpg');
      when(() => mockMedia.ensureAudio(any()))
          .thenAnswer((_) async => '/local/audio.mp3');
      when(() => mockLocal.saveFullCatalogTransaction(any(), any(), any()))
          .thenAnswer((_) async {});
      when(() => mockLocal.getAllLocalImagePaths())
          .thenThrow(Exception('cleanup error'));
      when(() => mockLogger.warning(any())).thenReturn(null);

      final result = await repository.downloadAndSaveCatalog();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockLogger.warning(any())).called(1);
    });
  });
}
