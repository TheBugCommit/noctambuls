import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.appTheme});

  final AppTheme appTheme;

  @override
  List<Object?> get props => [appTheme];
}
