import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

final class ToggleThemeRequested extends ThemeEvent {
  const ToggleThemeRequested();
}

final class SetThemeRequested extends ThemeEvent {
  const SetThemeRequested(this.theme);

  final AppTheme theme;

  @override
  List<Object?> get props => [theme];
}
