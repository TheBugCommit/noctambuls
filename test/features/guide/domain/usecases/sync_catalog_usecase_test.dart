import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';
import 'package:noctambuls/features/guide/domain/usecases/sync_catalog_usecase.dart';

class MockBirdsRepository extends Mock implements BirdsRepository {}

void main() {
  late MockBirdsRepository mockRepo;
  late SyncCatalogUseCase usecase;

  setUp(() {
    mockRepo = MockBirdsRepository();
    usecase = SyncCatalogUseCase(mockRepo);
  });

  void stubVersions({
    required Result<String?> localResult,
    required Result<String> remoteResult,
  }) {
    when(() => mockRepo.getLocalVersion()).thenAnswer((_) async => localResult);
    when(() => mockRepo.getRemoteVersion()).thenAnswer((_) async => remoteResult);
  }

  group('sense descàrrega', () {
    test('remoteVersion=null i localVersion=null → Err(CatalogSyncFailure)', () async {
      stubVersions(
        localResult: const Err(GuideFetchFailure()),
        remoteResult: const Err(GuideFetchFailure()),
      );

      final result = await usecase();

      expect(result, isA<Err<Unit>>());
      expect((result as Err<Unit>).failure, isA<CatalogSyncFailure>());
      verifyNever(() => mockRepo.downloadAndSaveCatalog());
    });

    test('remoteVersion=null, localVersion=v1 → Ok(Unit) sense baixar', () async {
      stubVersions(
        localResult: const Ok('v1'),
        remoteResult: const Err(GuideFetchFailure()),
      );

      final result = await usecase();

      expect(result, isA<Ok<Unit>>());
      verifyNever(() => mockRepo.downloadAndSaveCatalog());
    });

    test("remoteVersion='v1' == localVersion='v1' → Ok(Unit) sense baixar", () async {
      stubVersions(
        localResult: const Ok('v1'),
        remoteResult: const Ok('v1'),
      );

      final result = await usecase();

      expect(result, isA<Ok<Unit>>());
      verifyNever(() => mockRepo.downloadAndSaveCatalog());
    });
  });

  group('amb descàrrega', () {
    test("remoteVersion='v2' != localVersion='v1' → crida downloadAndSaveCatalog", () async {
      stubVersions(
        localResult: const Ok('v1'),
        remoteResult: const Ok('v2'),
      );
      when(() => mockRepo.downloadAndSaveCatalog())
          .thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockRepo.downloadAndSaveCatalog()).called(1);
    });

    test('primera sync (localVersion=null, remote diferent) → crida downloadAndSaveCatalog', () async {
      stubVersions(
        localResult: const Ok(null),
        remoteResult: const Ok('v1'),
      );
      when(() => mockRepo.downloadAndSaveCatalog())
          .thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockRepo.downloadAndSaveCatalog()).called(1);
    });

    test('downloadAndSaveCatalog falla → propaga Err', () async {
      stubVersions(
        localResult: const Ok('v1'),
        remoteResult: const Ok('v2'),
      );
      when(() => mockRepo.downloadAndSaveCatalog())
          .thenAnswer((_) async => const Err(CatalogSyncFailure()));

      final result = await usecase();

      expect(result, isA<Err<Unit>>());
    });
  });
}
