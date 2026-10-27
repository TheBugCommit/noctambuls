import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';
import 'package:noctambuls/features/guide/domain/usecases/accept_aud_warning_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/check_audio_warning_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_state.dart';

class MockGetBirdsUseCase extends Mock implements GetBirdsUseCase {}

class MockCheckAudioWarningUseCase extends Mock
    implements CheckAudioWarningUseCase {}

class MockAcceptAudioWarningUseCase extends Mock
    implements AcceptAudioWarningUseCase {}

class MockIAppLogger extends Mock implements IAppLogger {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockGetBirdsUseCase mockGetBirds;
  late MockCheckAudioWarningUseCase mockCheckWarning;
  late MockAcceptAudioWarningUseCase mockAcceptWarning;
  late MockIAppLogger mockLogger;

  const tBird = Bird(
    id: 'b1',
    commonName: 'Merla',
    scientificName: 'Turdus merula',
    description: 'Ocell comú',
    imageUrl: 'https://example.com/img.jpg',
    audioUrl: 'https://example.com/audio.mp3',
    infoUrl: 'https://example.com/info',
  );
  const tAudioPath = '/local/b1.mp3';

  setUpAll(() {
    registerFallbackValue(FakeFailure());
  });

  setUp(() {
    mockGetBirds = MockGetBirdsUseCase();
    mockCheckWarning = MockCheckAudioWarningUseCase();
    mockAcceptWarning = MockAcceptAudioWarningUseCase();
    mockLogger = MockIAppLogger();
  });

  GuideBloc buildBloc() => GuideBloc(
    getBirdsUseCase: mockGetBirds,
    logger: mockLogger,
    checkAudioWarningUseCase: mockCheckWarning,
    acceptAudioWarningUseCase: mockAcceptWarning,
  );

  group('LoadBirds', () {
    blocTest<GuideBloc, GuideState>(
      'llista no-buida → GuideLoading, GuideLoaded',
      build: buildBloc,
      setUp: () {
        when(() => mockGetBirds(any()))
            .thenAnswer((_) async => const Ok([tBird]));
      },
      act: (bloc) => bloc.add(const LoadBirds(languageCode: 'ca')),
      expect: () => [
        const GuideLoading(),
        isA<GuideLoaded>().having((s) => s.birds, 'birds', [tBird]),
      ],
    );

    blocTest<GuideBloc, GuideState>(
      'llista buida → GuideLoading, GuideEmptyNeedsSync',
      build: buildBloc,
      setUp: () {
        when(() => mockGetBirds(any()))
            .thenAnswer((_) async => const Ok(<Bird>[]));
      },
      act: (bloc) => bloc.add(const LoadBirds(languageCode: 'ca')),
      expect: () => [
        const GuideLoading(),
        const GuideEmptyNeedsSync(),
      ],
    );

    blocTest<GuideBloc, GuideState>(
      'Err → GuideLoading, GuideError',
      build: buildBloc,
      setUp: () {
        when(() => mockGetBirds(any()))
            .thenAnswer((_) async => const Err(GuideFetchFailure()));
        when(() => mockLogger.failure(any())).thenReturn(null);
      },
      act: (bloc) => bloc.add(const LoadBirds(languageCode: 'ca')),
      expect: () => [
        const GuideLoading(),
        isA<GuideError>(),
      ],
    );
  });

  group('CheckBirdAudioWarningRequested', () {
    blocTest<GuideBloc, GuideState>(
      'estat no és GuideLoaded → cap canvi d\'estat',
      build: buildBloc,
      act: (bloc) => bloc.add(
        const CheckBirdAudioWarningRequested(audioPath: tAudioPath),
      ),
      expect: () => [],
    );

    blocTest<GuideBloc, GuideState>(
      'checkAudioWarning retorna Ok(false) → GuideLoaded amb action=GuideAudioWarning',
      build: buildBloc,
      seed: () => const GuideLoaded(birds: [tBird]),
      setUp: () {
        when(() => mockCheckWarning())
            .thenAnswer((_) async => const Ok(false));
      },
      act: (bloc) => bloc.add(
        const CheckBirdAudioWarningRequested(audioPath: tAudioPath),
      ),
      expect: () => [
        isA<GuideLoaded>().having(
          (s) => s.action,
          'action',
          isA<GuideAudioWarning>().having(
            (a) => a.audioPath,
            'audioPath',
            tAudioPath,
          ),
        ),
      ],
    );

    blocTest<GuideBloc, GuideState>(
      'checkAudioWarning retorna Ok(true) → tot i així es mostra l\'avís '
      '(GuideAudioWarning)',
      build: buildBloc,
      seed: () => const GuideLoaded(birds: [tBird]),
      setUp: () {
        when(() => mockCheckWarning())
            .thenAnswer((_) async => const Ok(true));
      },
      act: (bloc) => bloc.add(
        const CheckBirdAudioWarningRequested(audioPath: tAudioPath),
      ),
      expect: () => [
        isA<GuideLoaded>().having(
          (s) => s.action,
          'action',
          isA<GuideAudioWarning>().having(
            (a) => a.audioPath,
            'audioPath',
            tAudioPath,
          ),
        ),
      ],
    );

    blocTest<GuideBloc, GuideState>(
      'checkAudioWarning retorna Err → tractat com false, emet GuideAudioWarning',
      build: buildBloc,
      seed: () => const GuideLoaded(birds: [tBird]),
      setUp: () {
        when(() => mockCheckWarning())
            .thenAnswer((_) async => Err(const UnknownFailure()));
      },
      act: (bloc) => bloc.add(
        const CheckBirdAudioWarningRequested(audioPath: tAudioPath),
      ),
      expect: () => [
        isA<GuideLoaded>().having(
          (s) => s.action,
          'action',
          isA<GuideAudioWarning>(),
        ),
      ],
    );

    blocTest<GuideBloc, GuideState>(
      'un cop acceptat l\'avís, una nova petició dins la mateixa sessió '
      'aprova la reproducció sense tornar a mostrar-lo',
      build: buildBloc,
      seed: () => const GuideLoaded(birds: [tBird]),
      setUp: () {
        when(() => mockAcceptWarning())
            .thenAnswer((_) async => const Ok(Unit.instance));
        when(() => mockCheckWarning())
            .thenAnswer((_) async => const Ok(false));
      },
      act: (bloc) async {
        bloc.add(const AcceptAudioWarning(audioPath: tAudioPath));
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const CheckBirdAudioWarningRequested(audioPath: tAudioPath),
        );
      },
      expect: () => [
        isA<GuideLoaded>().having(
          (s) => s.action,
          'action',
          isA<GuideAudioPlayApproved>(),
        ),
        isA<GuideLoaded>().having(
          (s) => s.action,
          'action',
          isA<GuideAudioPlayApproved>(),
        ),
      ],
    );
  });

  group('AcceptAudioWarning', () {
    blocTest<GuideBloc, GuideState>(
      'estat no és GuideLoaded → cap canvi d\'estat',
      build: buildBloc,
      act: (bloc) => bloc.add(const AcceptAudioWarning(audioPath: tAudioPath)),
      expect: () => [],
    );

    blocTest<GuideBloc, GuideState>(
      'acceptAudioWarning retorna Ok(Unit) → GuideLoaded amb action=GuideAudioPlayApproved',
      build: buildBloc,
      seed: () => const GuideLoaded(birds: [tBird]),
      setUp: () {
        when(() => mockAcceptWarning())
            .thenAnswer((_) async => const Ok(Unit.instance));
      },
      act: (bloc) => bloc.add(const AcceptAudioWarning(audioPath: tAudioPath)),
      expect: () => [
        isA<GuideLoaded>().having(
          (s) => s.action,
          'action',
          isA<GuideAudioPlayApproved>().having(
            (a) => a.audioPath,
            'audioPath',
            tAudioPath,
          ),
        ),
      ],
    );

    blocTest<GuideBloc, GuideState>(
      'acceptAudioWarning retorna Err → loga failure, cap canvi d\'estat',
      build: buildBloc,
      seed: () => const GuideLoaded(birds: [tBird]),
      setUp: () {
        when(() => mockAcceptWarning())
            .thenAnswer((_) async => Err(const UnknownFailure()));
        when(() => mockLogger.failure(any())).thenReturn(null);
      },
      act: (bloc) => bloc.add(const AcceptAudioWarning(audioPath: tAudioPath)),
      expect: () => [],
      verify: (_) {
        verify(() => mockLogger.failure(any())).called(1);
      },
    );
  });
}
