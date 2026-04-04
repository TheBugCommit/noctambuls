import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';

abstract class ThemeRepository {
  AppTheme getTheme();
  Future<void> saveTheme(AppTheme theme);
  AppTheme getSystemTheme();
}
