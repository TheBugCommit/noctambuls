import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/data/datasources/audio_preferences_local_datasource.dart';
import 'package:noctambuls/features/guide/data/repositories/audio_preferences_repository_impl.dart';

class MockAudioPreferencesLocalDataSource extends Mock
    implements AudioPreferencesLocalDataSource {}

class MockIAppLogger extends Mock implements IAppLogger {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockAudioPreferencesLocalDataSource mockLocal;
  late MockIAppLogger mockLogger;
  late AudioPreferencesRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeFailure());
  });

  setUp(() {
    mockLocal = MockAudioPreferencesLocalDataSource();
    mockLogger = MockIAppLogger();
    repository = AudioPreferencesRepositoryImpl(
      localDataSource: mockLocal,
      logger: mockLogger,
    );
  });

  group('hasAcceptedWarning', () {
    test('èxit → Ok(true)', () async {
      when(() => mockLocal.hasAcceptedWarning()).thenAnswer((_) async => true);

      final result = await repository.hasAcceptedWarning();

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isTrue);
    });

    test('èxit → Ok(false)', () async {
      when(() => mockLocal.hasAcceptedWarning()).thenAnswer((_) async => false);

      final result = await repository.hasAcceptedWarning();

      expect((result as Ok<bool>).value, isFalse);
    });

    test('excepció → Err(UnknownFailure)', () async {
      when(() => mockLocal.hasAcceptedWarning()).thenThrow(Exception('prefs error'));

      final result = await repository.hasAcceptedWarning();

      expect(result, isA<Err<bool>>());
      expect((result as Err<bool>).failure, isA<UnknownFailure>());
    });
  });

  group('setWarningAccepted', () {
    test('èxit → Ok(Unit)', () async {
      when(() => mockLocal.setWarningAccepted()).thenAnswer((_) async {});

      final result = await repository.setWarningAccepted();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockLocal.setWarningAccepted()).called(1);
    });

    test('excepció → Err(UnknownFailure)', () async {
      when(() => mockLocal.setWarningAccepted()).thenThrow(Exception('prefs error'));
      when(() => mockLogger.failure(any())).thenReturn(null);

      final result = await repository.setWarningAccepted();

      expect(result, isA<Err<Unit>>());
      expect((result as Err<Unit>).failure, isA<UnknownFailure>());
    });
  });
}
