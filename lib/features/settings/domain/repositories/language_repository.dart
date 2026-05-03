import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';

abstract class LanguageRepository {
  AppLanguage getLanguage();

  Future<Result<Unit>> saveLanguage(AppLanguage language);
}
