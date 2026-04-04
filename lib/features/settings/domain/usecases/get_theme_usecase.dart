import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';
import 'package:noctambuls/features/settings/domain/repositories/theme_repository.dart';

class GetThemeUseCase {
  GetThemeUseCase(this.repository);
  final ThemeRepository repository;

  AppTheme call() => repository.getTheme();
}
