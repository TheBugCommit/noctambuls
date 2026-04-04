import 'package:noctambuls/features/settings/domain/entities/app_language.dart';
import 'package:noctambuls/features/settings/domain/repositories/language_repository.dart';

class GetLanguageUseCase {
  GetLanguageUseCase(this.repository);
  final LanguageRepository repository;

  AppLanguage call() => repository.getLanguage();
}
