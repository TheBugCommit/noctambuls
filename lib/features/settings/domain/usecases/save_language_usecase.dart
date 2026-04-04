import 'package:noctambuls/features/settings/domain/entities/app_language.dart';
import 'package:noctambuls/features/settings/domain/repositories/language_repository.dart';

class SaveLanguageUseCase {
  SaveLanguageUseCase(this.repository);
  final LanguageRepository repository;

  Future<void> call(AppLanguage language) => repository.saveLanguage(language);
}
