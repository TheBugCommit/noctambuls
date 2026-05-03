import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_system_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_theme_usecase.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_event.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required this.getThemeUseCase,
    required this.saveThemeUseCase,
    required this.getSystemThemeUseCase,
    required this.logger,
  }) : super(ThemeState(appTheme: getThemeUseCase())) {
    on<ToggleThemeRequested>(_onToggleTheme);
    on<SetThemeRequested>(_onSetTheme);
  }

  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;
  final GetSystemThemeUseCase getSystemThemeUseCase;
  final IAppLogger logger;

  Future<void> _onToggleTheme(
    ToggleThemeRequested event,
    Emitter<ThemeState> emit,
  ) async {
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

    await _saveAndEmitTheme(newTheme, emit);
  }

  Future<void> _onSetTheme(
    SetThemeRequested event,
    Emitter<ThemeState> emit,
  ) async {
    await _saveAndEmitTheme(event.theme, emit);
  }

  Future<void> _saveAndEmitTheme(
    AppTheme theme,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(appTheme: theme));
    final result = await saveThemeUseCase(theme);
    result.when(
      success: (_) {},
      failure: logger.failure,
    );
  }
}
