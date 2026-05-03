import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_system_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_theme_usecase.dart';
// IMPORTEM EL BLOC I ELS EVENTS EN LLOC DEL CUBIT
import 'package:noctambuls/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_event.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_state.dart';

class MockGetThemeUseCase extends Mock implements GetThemeUseCase {}

class MockSaveThemeUseCase extends Mock implements SaveThemeUseCase {}

class MockGetSystemThemeUseCase extends Mock implements GetSystemThemeUseCase {}

class MockLogger extends Mock implements IAppLogger {}

void main() {
  late ThemeBloc themeBloc;
  late MockGetThemeUseCase mockGetTheme;
  late MockSaveThemeUseCase mockSaveTheme;
  late MockGetSystemThemeUseCase mockGetSystemTheme;
  late MockLogger mockLogger;

  setUpAll(() {
    registerFallbackValue(AppTheme.light);
  });

  setUp(() {
    mockGetTheme = MockGetThemeUseCase();
    mockSaveTheme = MockSaveThemeUseCase();
    mockGetSystemTheme = MockGetSystemThemeUseCase();
    mockLogger = MockLogger();

    when(() => mockGetTheme.call()).thenReturn(AppTheme.light);
    when(() => mockSaveTheme.call(any())).thenAnswer(
      (_) async => const Ok(Unit.instance),
    );

    themeBloc = ThemeBloc(
      getThemeUseCase: mockGetTheme,
      saveThemeUseCase: mockSaveTheme,
      getSystemThemeUseCase: mockGetSystemTheme,
      logger: mockLogger,
    );
  });

  tearDown(() async {
    await themeBloc.close();
  });

  group('ThemeBloc', () {
    test("L'estat inicial hauria de ser AppTheme.light", () {
      expect(themeBloc.state.appTheme, AppTheme.light);
    });

    blocTest<ThemeBloc, ThemeState>(
      "Emet [ThemeState(AppTheme.dark)] quan s'afegeix ToggleThemeRequested i l'estat actual és light",
      build: () => themeBloc,
      act: (bloc) => bloc.add(const ToggleThemeRequested()),
      expect: () => [
        const ThemeState(appTheme: AppTheme.dark),
      ],
      verify: (_) {
        verify(() => mockSaveTheme.call(AppTheme.dark)).called(1);
      },
    );

    blocTest<ThemeBloc, ThemeState>(
      "Emet [ThemeState(AppTheme.dark)] quan s'afegeix SetThemeRequested(AppTheme.dark)",
      build: () => themeBloc,
      act: (bloc) => bloc.add(const SetThemeRequested(AppTheme.dark)),
      expect: () => [
        const ThemeState(appTheme: AppTheme.dark),
      ],
      verify: (_) {
        verify(() => mockSaveTheme.call(AppTheme.dark)).called(1);
      },
    );
  });
}
