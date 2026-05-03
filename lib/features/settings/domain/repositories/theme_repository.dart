import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';

abstract class ThemeRepository {
  AppTheme getTheme();

  AppTheme getSystemTheme();

  Future<Result<Unit>> saveTheme(AppTheme theme);
}
