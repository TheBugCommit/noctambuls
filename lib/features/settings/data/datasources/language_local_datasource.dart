import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  String? getCachedLanguage();
  Future<void> cacheLanguage(String languageString);
}

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  LanguageLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;
  static const String _languageKey = 'app_language_pref';

  @override
  String? getCachedLanguage() => sharedPreferences.getString(_languageKey);

  @override
  Future<void> cacheLanguage(String languageString) async {
    await sharedPreferences.setString(_languageKey, languageString);
  }
}
