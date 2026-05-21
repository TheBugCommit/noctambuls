import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/pagination_meta.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/sync_pending_sessions_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

void main() {
  late SyncPendingSessionsUseCase usecase;
  late MockSessionRepository mockRepository;

  setUp(() {
    mockRepository = MockSessionRepository();
    usecase = SyncPendingSessionsUseCase(mockRepository);
  });

  group('SyncPendingSessionsUseCase', () {
    test(
      'hauria de delegar a repository.syncPendingSessions i retornar Ok(meta)',
      () async {
        const tMeta = PaginationMeta(
          currentPage: 1,
          totalPages: 1,
          totalItems: 5,
          hasMore: false,
        );

        when(
          () => mockRepository.syncPendingSessions(),
        ).thenAnswer((_) async => const Ok(tMeta));

        final result = await usecase();

        expect(result.isOk, isTrue);
        expect((result as Ok<PaginationMeta>).value, tMeta);
        verify(() => mockRepository.syncPendingSessions()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'hauria de propagar SyncNetworkFailure si el repositori falla per xarxa',
      () async {
        when(
          () => mockRepository.syncPendingSessions(),
        ).thenAnswer((_) async => const Err(SyncNetworkFailure()));

        final result = await usecase();

        expect(result, isA<Err<PaginationMeta>>());
        expect(
          (result as Err<PaginationMeta>).failure,
          isA<SyncNetworkFailure>(),
        );
      },
    );

    test(
      'hauria de propagar SyncServerFailure si el servidor retorna error',
      () async {
        when(
          () => mockRepository.syncPendingSessions(),
        ).thenAnswer((_) async => const Err(SyncServerFailure()));

        final result = await usecase();

        expect(result, isA<Err<PaginationMeta>>());
        expect(
          (result as Err<PaginationMeta>).failure,
          isA<SyncServerFailure>(),
        );
      },
    );

    test(
      'hauria de propagar DatabaseFailure per errors inesperats',
      () async {
        when(
          () => mockRepository.syncPendingSessions(),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase();

        expect(result, isA<Err<PaginationMeta>>());
        expect(
          (result as Err<PaginationMeta>).failure,
          isA<DatabaseFailure>(),
        );
      },
    );
  });
}
