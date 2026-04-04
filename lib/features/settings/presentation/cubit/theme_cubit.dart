import 'package:flutter_bloc/flutter_bloc.dart';
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
  }) : super(ThemeState(appTheme: getThemeUseCase()));
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;
  final GetSystemThemeUseCase getSystemThemeUseCase;

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

    emit(ThemeState(appTheme: newTheme));
    await saveThemeUseCase(newTheme);
  }
}
