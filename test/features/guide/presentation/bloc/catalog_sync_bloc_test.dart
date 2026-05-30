import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart'
    as guide_failures;
import 'package:noctambuls/features/guide/domain/usecases/check_is_catalog_empty_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/sync_catalog_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';

class MockSyncCatalogUseCase extends Mock implements SyncCatalogUseCase {}

class MockCheckIsCatalogEmptyUseCase extends Mock
    implements CheckIsCatalogEmptyUseCase {}

class MockIAppLogger extends Mock implements IAppLogger {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockSyncCatalogUseCase mockSync;
  late MockCheckIsCatalogEmptyUseCase mockCheckEmpty;
  late MockIAppLogger mockLogger;

  setUpAll(() {
    registerFallbackValue(FakeFailure());
  });

  setUp(() {
    mockSync = MockSyncCatalogUseCase();
    mockCheckEmpty = MockCheckIsCatalogEmptyUseCase();
    mockLogger = MockIAppLogger();
  });

  CatalogSyncBloc buildBloc() => CatalogSyncBloc(
    syncCatalogUseCase: mockSync,
    checkIsCatalogEmptyUseCase: mockCheckEmpty,
    logger: mockLogger,
  );

  group('CatalogSyncEventRequest', () {
    blocTest<CatalogSyncBloc, CatalogSyncState>(
      'estat CatalogSyncInProgress → cap acció (guard early return)',
      build: buildBloc,
      seed: () => const CatalogSyncInProgress(isCatalogEmpty: false),
      act: (bloc) => bloc.add(const CatalogSyncEventRequest()),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockSync());
        verifyNever(() => mockCheckEmpty());
      },
    );

    blocTest<CatalogSyncBloc, CatalogSyncState>(
      'catàleg buit + sync èxit → CatalogSyncInProgress(true) → CatalogSyncSuccess',
      build: buildBloc,
      setUp: () {
        when(() => mockCheckEmpty()).thenAnswer((_) async => true);
        when(() => mockSync()).thenAnswer((_) async => const Ok(Unit.instance));
      },
      act: (bloc) => bloc.add(const CatalogSyncEventRequest()),
      expect: () => [
        const CatalogSyncInProgress(isCatalogEmpty: true),
        const CatalogSyncSuccess(),
      ],
    );

    blocTest<CatalogSyncBloc, CatalogSyncState>(
      'catàleg no-buit + sync èxit → CatalogSyncInProgress(false) → CatalogSyncSuccess',
      build: buildBloc,
      setUp: () {
        when(() => mockCheckEmpty()).thenAnswer((_) async => false);
        when(() => mockSync()).thenAnswer((_) async => const Ok(Unit.instance));
      },
      act: (bloc) => bloc.add(const CatalogSyncEventRequest()),
      expect: () => [
        const CatalogSyncInProgress(isCatalogEmpty: false),
        const CatalogSyncSuccess(),
      ],
    );

    blocTest<CatalogSyncBloc, CatalogSyncState>(
      'sync falla, catàleg buit → CatalogSyncInProgress → CatalogSyncFailure(isCatalogEmpty: true)',
      build: buildBloc,
      setUp: () {
        when(() => mockCheckEmpty()).thenAnswer((_) async => true);
        when(() => mockSync()).thenAnswer(
          (_) async =>
              const Err(guide_failures.CatalogSyncFailure()),
        );
        when(() => mockLogger.failure(any())).thenReturn(null);
      },
      act: (bloc) => bloc.add(const CatalogSyncEventRequest()),
      expect: () => [
        const CatalogSyncInProgress(isCatalogEmpty: true),
        isA<CatalogSyncFailure>()
            .having((s) => s.isCatalogEmpty, 'isCatalogEmpty', isTrue)
            .having((s) => s.showGlobalError, 'showGlobalError', isFalse),
      ],
    );

    blocTest<CatalogSyncBloc, CatalogSyncState>(
      'sync falla amb showGlobalError=true → CatalogSyncFailure(showGlobalError: true)',
      build: buildBloc,
      setUp: () {
        when(() => mockCheckEmpty()).thenAnswer((_) async => false);
        when(() => mockSync()).thenAnswer(
          (_) async =>
              const Err(guide_failures.CatalogSyncFailure()),
        );
        when(() => mockLogger.failure(any())).thenReturn(null);
      },
      act: (bloc) =>
          bloc.add(const CatalogSyncEventRequest(showGlobalError: true)),
      expect: () => [
        const CatalogSyncInProgress(isCatalogEmpty: false),
        isA<CatalogSyncFailure>()
            .having((s) => s.showGlobalError, 'showGlobalError', isTrue),
      ],
    );
  });
}
