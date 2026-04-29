import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_system_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_theme_usecase.dart';
import 'package:noctambuls/features/settings/presentation/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required this.getThemeUseCase,
    required this.saveThemeUseCase,
    required this.getSystemThemeUseCase,
    required this.logger,
  }) : super(ThemeState(appTheme: getThemeUseCase()));

  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;
  final GetSystemThemeUseCase getSystemThemeUseCase;
  final IAppLogger logger;

  Future<void> toggleTheme() async {
    final currentTheme = state.appTheme;
    AppTheme newTheme;

    if (currentTheme == AppTheme.system) {
      final currentSystemTheme = getSystemThemeUseCase();
      newTheme = (currentSystemTheme == AppTheme.dark)
          ? AppTheme.light
          : AppTheme.dark;
    } else {
      newTheme = (currentTheme == AppTheme.light)
          ? AppTheme.dark
          : AppTheme.light;
    }

    await setTheme(newTheme);
  }

  Future<void> setTheme(AppTheme theme) async {
    emit(ThemeState(appTheme: theme));
    final result = await saveThemeUseCase(theme);
    result.when(
      success: (_) {},
      failure: logger.failure,
    );
  }
}
