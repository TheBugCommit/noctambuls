import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/save_observation_usecase.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

class FakeObservationSession extends Fake implements ObservationSession {}

class FakeObservationRecord extends Fake implements ObservationRecord {}

void main() {
  late SaveObservationUseCase usecase;
  late MockSessionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeObservationSession());
    registerFallbackValue(FakeObservationRecord());
  });

  setUp(() {
    mockRepository = MockSessionRepository();
    usecase = SaveObservationUseCase(mockRepository);
  });

  final now = DateTime(2024, 6, 15, 10);

  final tSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    createdAt: now,
    updatedAt: now,
  );

  final tLockedSession = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    isLocked: true,
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

  final tExistingRecord = ObservationRecord(
    id: 'obs-existing',
    sessionId: 'sess-1',
    speciesId: 'parus_major',
    contactType: ContactType.visual,
    bearing: 45.0,
    startTime: now,
    endTime: now,
    createdAt: now,
    updatedAt: now,
    location: tLocation,
  );

  final tSessionWithRecord = ObservationSession(
    id: 'sess-1',
    annotatorId: 'user-1',
    sessionType: SessionType.incidental,
    createdAt: now,
    updatedAt: now,
    observations: [tExistingRecord],
  );

  group('SaveObservationUseCase', () {
    test('hauria de crear una nova observació i retornar Ok(record)', () async {
      when(
        () => mockRepository.getSessionById('sess-1'),
      ).thenAnswer((_) async => Ok(tSession));
      when(
        () => mockRepository.saveSession(any()),
      ).thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase(
        sessionId: 'sess-1',
        speciesId: 'parus_major',
        contactType: ContactType.visual,
        quantity: 1,
        bearing: 0.0,
        startTime: now,
        endTime: now,
        location: tLocation,
      );

      expect(result.isOk, isTrue);
      expect((result as Ok<ObservationRecord>).value.speciesId, 'parus_major');
      verify(() => mockRepository.saveSession(any())).called(1);
    });

    test(
      'hauria d\'editar una observació existent quan existingRecord != null',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tSessionWithRecord));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        final result = await usecase(
          sessionId: 'sess-1',
          speciesId: 'turdus_merula',
          contactType: ContactType.auditive,
          quantity: 2,
          bearing: 90.0,
          startTime: now,
          endTime: now,
          existingRecord: tExistingRecord,
          location: tLocation,
        );

        expect(result.isOk, isTrue);
        final saved = verify(
          () => mockRepository.saveSession(captureAny()),
        ).captured.first as ObservationSession;

        expect(
          saved.observations.any((r) => r.id == tExistingRecord.id),
          isTrue,
        );
        expect(saved.observations.length, 1);
      },
    );

    test(
      'hauria de retornar SessionNotFoundFailure si getSessionById retorna null',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Ok(null));

        final result = await usecase(
          sessionId: 'sess-1',
          speciesId: 'parus_major',
          contactType: ContactType.visual,
          quantity: 1,
          bearing: 0.0,
          startTime: now,
          endTime: now,
        );

        expect(result, isA<Err<ObservationRecord>>());
        expect(
          (result as Err<ObservationRecord>).failure,
          isA<SessionNotFoundFailure>(),
        );
        verifyNever(() => mockRepository.saveSession(any()));
      },
    );

    test(
      'hauria de retornar SessionLockedFailure si la sessió és locked',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(tLockedSession));

        final result = await usecase(
          sessionId: 'sess-1',
          speciesId: 'parus_major',
          contactType: ContactType.visual,
          quantity: 1,
          bearing: 0.0,
          startTime: now,
          endTime: now,
        );

        expect(result, isA<Err<ObservationRecord>>());
        expect(
          (result as Err<ObservationRecord>).failure,
          isA<SessionLockedFailure>(),
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
          speciesId: 'parus_major',
          contactType: ContactType.visual,
          quantity: 1,
          bearing: 0.0,
          startTime: now,
          endTime: now,
          location: tLocation,
        );

        expect(result, isA<Err<ObservationRecord>>());
        expect(
          (result as Err<ObservationRecord>).failure,
          isA<DatabaseFailure>(),
        );
      },
    );

    test(
      'hauria de propagar DatabaseFailure si getSessionById falla',
      () async {
        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => const Err(DatabaseFailure()));

        final result = await usecase(
          sessionId: 'sess-1',
          speciesId: 'parus_major',
          contactType: ContactType.visual,
          quantity: 1,
          bearing: 0.0,
          startTime: now,
          endTime: now,
        );

        expect(result, isA<Err<ObservationRecord>>());
        expect(
          (result as Err<ObservationRecord>).failure,
          isA<DatabaseFailure>(),
        );
      },
    );

    test(
      'hauria d\'aplicar newGlobalDate a tota la sessió (canvi de data)',
      () async {
        final sessionWithRecord = ObservationSession(
          id: 'sess-1',
          annotatorId: 'user-1',
          sessionType: SessionType.incidental,
          startTime: now,
          createdAt: now,
          updatedAt: now,
          observations: [tExistingRecord],
        );

        when(
          () => mockRepository.getSessionById('sess-1'),
        ).thenAnswer((_) async => Ok(sessionWithRecord));
        when(
          () => mockRepository.saveSession(any()),
        ).thenAnswer((_) async => const Ok(Unit.instance));

        final newDate = DateTime(2024, 7, 1);

        await usecase(
          sessionId: 'sess-1',
          speciesId: 'bubo_bubo',
          contactType: ContactType.auditive,
          quantity: 1,
          bearing: 0.0,
          startTime: now,
          endTime: now,
          location: tLocation,
          newGlobalDate: newDate,
        );

        final captured = verify(
          () => mockRepository.saveSession(captureAny()),
        ).captured.first as ObservationSession;

        expect(captured.startTime?.month, newDate.month);
        expect(captured.startTime?.day, newDate.day);
      },
    );
  });
}
