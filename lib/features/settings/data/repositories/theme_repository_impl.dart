import 'package:noctambuls/features/settings/data/datasources/theme_local_datasource.dart';
import 'package:noctambuls/features/settings/data/datasources/theme_system_datasource.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';
import 'package:noctambuls/features/settings/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({
    required this.localDataSource,
    required this.systemDataSource,
  });
  final ThemeLocalDataSource localDataSource;
  final ThemeSystemDataSource systemDataSource;

  @override
  AppTheme getTheme() {
    final themeString = localDataSource.getCachedTheme();

    return AppTheme.values.firstWhere(
      (theme) => theme.name == themeString,
      orElse: () => AppTheme.system,
    );
  }

  @override
  AppTheme getSystemTheme() {
    final isDark = systemDataSource.isSystemDarkMode();
    return isDark ? AppTheme.dark : AppTheme.light;
  }

  @override
  Future<void> saveTheme(AppTheme theme) async {
    await localDataSource.cacheTheme(theme.name);
  }
}
