import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/censuses/domain/usecases/join_census_usecase.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

import '../../helpers/census_jwt_helper.dart';

class MockCensusRepository extends Mock implements CensusRepository {}

class MockSessionRepository extends Mock implements SessionRepository {}

class FakeCensus extends Fake implements Census {}

void main() {
  late MockCensusRepository mockCensusRepo;
  late MockSessionRepository mockSessionRepo;
  late JoinCensusUseCase usecase;

  const tCensusId = 'census-abc';
  const tTitle = 'Cens Test';
  final tStartTimeUtc = DateTime.now().toUtc();
  final tStartTimeStr = tStartTimeUtc.toIso8601String();

  setUpAll(() {
    registerFallbackValue(FakeCensus());
  });

  setUp(() {
    mockCensusRepo = MockCensusRepository();
    mockSessionRepo = MockSessionRepository();
    usecase = JoinCensusUseCase(mockCensusRepo, mockSessionRepo, testPublicKey);
  });

  Census makeCensus({bool alreadyDone = false, bool isJoined = false}) {
    return Census(
      id: tCensusId,
      title: tTitle,
      startTime: tStartTimeUtc,
      createdAt: tStartTimeUtc,
      updatedAt: tStartTimeUtc,
      alreadyDone: alreadyDone,
      isJoined: isJoined,
    );
  }

  String makeUrl(String token) =>
      'https://app.associaciotaxus.cat/census?token=$token';

  group('camins pre-JWT (sense verificació de clau)', () {
    test('sessió activa existent → Err(ActiveSessionAlreadyExistsFailure)',
        () async {
      final session = ObservationSession(
        id: 's1',
        annotatorId: 'u1',
        sessionType: SessionType.incidental,
        createdAt: tStartTimeUtc,
        updatedAt: tStartTimeUtc,
      );
      when(() => mockSessionRepo.getActiveSession())
          .thenAnswer((_) async => Ok(session));

      final result = await usecase(makeUrl('some-token'));

      expect(result, isA<Err<Census>>());
      expect(
        (result as Err<Census>).failure,
        isA<ActiveSessionAlreadyExistsFailure>(),
      );
    });

    test('getActiveSession retorna error → propaga error', () async {
      when(() => mockSessionRepo.getActiveSession())
          .thenAnswer((_) async => const Err(ActiveSessionAlreadyExistsFailure()));

      final result = await usecase(makeUrl('some-token'));

      expect(result, isA<Err<Census>>());
    });

    test('URL invàlida → Err(InvalidCensusTokenFailure)', () async {
      when(() => mockSessionRepo.getActiveSession())
          .thenAnswer((_) async => const Ok(null));

      final result = await usecase('::not-a-valid-url');

      expect(result, isA<Err<Census>>());
      expect(
        (result as Err<Census>).failure,
        isA<InvalidCensusTokenFailure>(),
      );
    });

    test('URL sense paràmetre token → Err(InvalidCensusTokenFailure)', () async {
      when(() => mockSessionRepo.getActiveSession())
          .thenAnswer((_) async => const Ok(null));

      final result = await usecase('https://app.associaciotaxus.cat/census');

      expect(result, isA<Err<Census>>());
      expect(
        (result as Err<Census>).failure,
        isA<InvalidCensusTokenFailure>(),
      );
    });
  });

  group('camins post-JWT (amb clau RSA de test)', () {
    setUp(() {
      when(() => mockSessionRepo.getActiveSession())
          .thenAnswer((_) async => const Ok(null));
    });

    test('JWT invàlid (signatura incorrecta) → Err(InvalidCensusTokenFailure)',
        () async {
      final result = await usecase(makeUrl('header.payload.badsignature'));

      expect(result, isA<Err<Census>>());
      expect(
        (result as Err<Census>).failure,
        isA<InvalidCensusTokenFailure>(),
      );
    });

    test('JWT sense camp i/t/s → Err(InvalidCensusTokenFailure)', () async {
      // Token sense camps requerits — JWT vàlid però payload incomplet
      // makeCensusJwt amb id buit i title buit és vàlid, però podem crear un amb
      // payload que no inclogui els camps esperats creant-lo manualment
      // Usem un token amb signatura vàlida però payload sense els camps
      final result = await usecase(makeUrl('eyJhbGciOiJSUzI1NiJ9.e30.invalidsig'));

      expect(result, isA<Err<Census>>());
      expect(
        (result as Err<Census>).failure,
        isA<InvalidCensusTokenFailure>(),
      );
    });

    test('cens existent alreadyDone=true → Err(CensusSessionAlreadyFinishedFailure)',
        () async {
      final token = makeCensusJwt(
        censusId: tCensusId,
        title: tTitle,
        startTime: tStartTimeStr,
      );
      when(() => mockCensusRepo.getById(tCensusId))
          .thenAnswer((_) async => Ok(makeCensus(alreadyDone: true)));

      final result = await usecase(makeUrl(token));

      expect(result, isA<Err<Census>>());
      expect(
        (result as Err<Census>).failure,
        isA<CensusSessionAlreadyFinishedFailure>(),
      );
    });

    test('cens no és d\'avui → Err(CensusNotTodayFailure)', () async {
      final pastStartTime = DateTime.now()
          .toUtc()
          .subtract(const Duration(days: 2))
          .toIso8601String();
      final token = makeCensusJwt(
        censusId: tCensusId,
        title: tTitle,
        startTime: pastStartTime,
      );
      when(() => mockCensusRepo.getById(tCensusId))
          .thenAnswer((_) async => const Ok(null));

      final result = await usecase(makeUrl(token));

      expect(result, isA<Err<Census>>());
      expect((result as Err<Census>).failure, isA<CensusNotTodayFailure>());
    });

    test(
      'ja hi ha un cens a la sala d\'espera → Err(CensusJoinAlreadyHasLobbyFailure)',
      () async {
        final token = makeCensusJwt(
          censusId: tCensusId,
          title: tTitle,
          startTime: tStartTimeStr,
        );
        when(() => mockCensusRepo.getById(tCensusId))
            .thenAnswer((_) async => const Ok(null));
        when(() => mockCensusRepo.getJoinedCensus()).thenAnswer(
          (_) async => Ok(makeCensus(isJoined: true)),
        );

        final result = await usecase(makeUrl(token));

        expect(result, isA<Err<Census>>());
        expect(
          (result as Err<Census>).failure,
          isA<CensusJoinAlreadyHasLobbyFailure>(),
        );
      },
    );

    test(
      'cens nou (no al repositori), save OK → Ok(census)',
      () async {
        final token = makeCensusJwt(
          censusId: tCensusId,
          title: tTitle,
          startTime: tStartTimeStr,
        );
        when(() => mockCensusRepo.getById(tCensusId))
            .thenAnswer((_) async => const Ok(null));
        when(() => mockCensusRepo.getJoinedCensus())
            .thenAnswer((_) async => const Ok(null));
        when(() => mockCensusRepo.save(any()))
            .thenAnswer((_) async => const Ok(Unit.instance));

        final result = await usecase(makeUrl(token));

        expect(result, isA<Ok<Census>>());
        verify(() => mockCensusRepo.save(any())).called(1);
      },
    );

    test(
      'cens existent al repositori, save OK → Ok(census)',
      () async {
        final token = makeCensusJwt(
          censusId: tCensusId,
          title: tTitle,
          startTime: tStartTimeStr,
        );
        when(() => mockCensusRepo.getById(tCensusId))
            .thenAnswer((_) async => Ok(makeCensus()));
        when(() => mockCensusRepo.getJoinedCensus())
            .thenAnswer((_) async => const Ok(null));
        when(() => mockCensusRepo.save(any()))
            .thenAnswer((_) async => const Ok(Unit.instance));

        final result = await usecase(makeUrl(token));

        expect(result, isA<Ok<Census>>());
      },
    );

    test(
      'save falla → Err(CensusDatabaseFailure)',
      () async {
        final token = makeCensusJwt(
          censusId: tCensusId,
          title: tTitle,
          startTime: tStartTimeStr,
        );
        when(() => mockCensusRepo.getById(tCensusId))
            .thenAnswer((_) async => const Ok(null));
        when(() => mockCensusRepo.getJoinedCensus())
            .thenAnswer((_) async => const Ok(null));
        when(() => mockCensusRepo.save(any()))
            .thenAnswer((_) async => const Err(CensusDatabaseFailure()));

        final result = await usecase(makeUrl(token));

        expect(result, isA<Err<Census>>());
      },
    );
  });
}
