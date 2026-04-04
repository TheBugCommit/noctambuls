import 'package:noctambuls/features/settings/domain/entities/app_language.dart';

abstract class LanguageRepository {
  AppLanguage getLanguage();
  Future<void> saveLanguage(AppLanguage language);
}
