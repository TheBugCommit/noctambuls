import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  String? getCachedTheme();
  Future<void> cacheTheme(String themeString);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  ThemeLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;
  static const String _themeKey = 'app_theme_mode';

  @override
  String? getCachedTheme() {
    return sharedPreferences.getString(_themeKey);
  }

  @override
  Future<void> cacheTheme(String themeString) async {
    await sharedPreferences.setString(_themeKey, themeString);
  }
}
