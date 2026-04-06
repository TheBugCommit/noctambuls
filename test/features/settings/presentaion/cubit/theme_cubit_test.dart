import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_system_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_theme_usecase.dart';
import 'package:noctambuls/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:noctambuls/features/settings/presentation/cubit/theme_state.dart';

class MockGetThemeUseCase extends Mock implements GetThemeUseCase {}

class MockSaveThemeUseCase extends Mock implements SaveThemeUseCase {}

class MockGetSystemThemeUseCase extends Mock implements GetSystemThemeUseCase {}

void main() {
  late ThemeCubit themeCubit;
  late MockGetThemeUseCase mockGetTheme;
  late MockSaveThemeUseCase mockSaveTheme;
  late MockGetSystemThemeUseCase mockGetSystemTheme;

  setUpAll(() {
    registerFallbackValue(AppTheme.light);
  });

  setUp(() {
    mockGetTheme = MockGetThemeUseCase();
    mockSaveTheme = MockSaveThemeUseCase();
    mockGetSystemTheme = MockGetSystemThemeUseCase();

    when(() => mockGetTheme.call()).thenReturn(AppTheme.light);
    when(() => mockSaveTheme.call(any())).thenAnswer(
      (_) async => const Ok(Unit.instance),
    );

    themeCubit = ThemeCubit(
      getThemeUseCase: mockGetTheme,
      saveThemeUseCase: mockSaveTheme,
      getSystemThemeUseCase: mockGetSystemTheme,
    );
  });

  tearDown(() async {
    await themeCubit.close();
  });

  group('ThemeCubit', () {
    test("L'estat inicial hauria de ser AppTheme.light", () {
      expect(themeCubit.state.appTheme, AppTheme.light);
    });

    blocTest<ThemeCubit, ThemeState>(
      "Emet [ThemeState(AppTheme.dark)] quan es crida toggleTheme i l'estat actual és light",
      build: () => themeCubit,
      act: (cubit) => cubit.toggleTheme(),
      expect: () => [
        const ThemeState(appTheme: AppTheme.dark),
      ],
      verify: (_) {
        verify(() => mockSaveTheme.call(AppTheme.dark)).called(1);
      },
    );

    blocTest<ThemeCubit, ThemeState>(
      'Emet [ThemeState(AppTheme.dark)] quan es crida setTheme(AppTheme.dark)',
      build: () => themeCubit,
      act: (cubit) => cubit.setTheme(AppTheme.dark),
      expect: () => [
        const ThemeState(appTheme: AppTheme.dark),
      ],
      verify: (_) {
        verify(() => mockSaveTheme.call(AppTheme.dark)).called(1);
      },
    );
  });
}
