import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/settings/data/datasources/language_local_datasource.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';
import 'package:noctambuls/features/settings/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  LanguageRepositoryImpl({required this.localDataSource});

  final LanguageLocalDataSource localDataSource;

  @override
  AppLanguage getLanguage() {
    final langString = localDataSource.getCachedLanguage();
    return AppLanguage.values.firstWhere(
      (lang) => lang.name == langString,
      orElse: () => AppLanguage.system,
    );
  }

  @override
  Future<Result<Unit>> saveLanguage(AppLanguage language) async {
    try {
      await localDataSource.cacheLanguage(language.name);
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const CacheFailure().withDebug(e, st));
    }
  }
}
