import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';
import 'package:noctambuls/features/settings/domain/repositories/theme_repository.dart';

class SaveThemeUseCase {
  SaveThemeUseCase(this.repository);
  final ThemeRepository repository;

  Future<void> call(AppTheme theme) => repository.saveTheme(theme);
}
