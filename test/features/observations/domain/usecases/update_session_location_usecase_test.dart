import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_location_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

void main() {
  late UpdateSessionLocationUseCase usecase;
  late MockSessionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
  });

  setUp(() {
    mockRepository = MockSessionRepository();
    usecase = UpdateSessionLocationUseCase(mockRepository);
  });

  final now = DateTime(2024);

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.census,
    createdAt: now,
    updatedAt: now,
  );

  final tLocation = GeoPosition(
    latitude: 41.3,
    longitude: 2.1,
    accuracy: 5.0,
    altitude: 100.0,
    altitudeAccuracy: 10.0,
    timestamp: now,
    locationSource: LocationSource.gps,
  );

  group('UpdateSessionLocationUseCase', () {
    test('hauria d\'actualitzar la location i retornar Ok', () async {
      when(
        () => mockRepository.getSessionById('sess-1'),
      ).thenAnswer((_) async => Ok(tSession));
      when(
        () => mockRepository.saveSession(any()),
      ).thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase(
        sessionId: 'sess-1',
        location: tLocation,
      );

      expect(result.isOk, isTrue);
      final captured = verify(
        () => mockRepository.saveSession(captureAny()),
      ).captured.first as ObservationSession;
      expect(captured.location, tLocation);
    });

    test(
      'hauria de retornar SessionNotFoundFailure si la sessió no existeix',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Ok(null));

        final result = await usecase(sessionId: 'sess-1');

        expect(result, isA<Err<Unit>>());
        expect(
          (result as Err<Unit>).failure,
          isA<SessionNotFoundFailure>(),
        );
        verifyNever(() => mockRepository.saveSession(any()));
      },
    );

    test(
      'hauria de propagar DatabaseFailure si saveSession falla',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tSession));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(
          sessionId: 'sess-1',
          location: tLocation,
        );

        expect(result, isA<Err<Unit>>());
        expect((result as Err<Unit>).failure, isA<DatabaseFailure>());
      },
    );

    test(
      'hauria de propagar DatabaseFailure si getSessionById falla',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(sessionId: 'sess-1');

        expect(result, isA<Err<Unit>>());
        expect((result as Err<Unit>).failure, isA<DatabaseFailure>());
      },
    );
  });
}
