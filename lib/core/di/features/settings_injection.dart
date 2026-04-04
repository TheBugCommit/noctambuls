import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/features/settings/data/datasources/language_local_datasource.dart';
import 'package:noctambuls/features/settings/data/datasources/theme_local_datasource.dart';
import 'package:noctambuls/features/settings/data/datasources/theme_system_datasource.dart';
import 'package:noctambuls/features/settings/data/repositories/language_repository_impl.dart';
import 'package:noctambuls/features/settings/data/repositories/theme_repository_impl.dart';
import 'package:noctambuls/features/settings/domain/repositories/language_repository.dart';
import 'package:noctambuls/features/settings/domain/repositories/theme_repository.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_system_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_theme_usecase.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_cubit.dart';
import 'package:noctambuls/features/settings/presentation/cubit/theme_cubit.dart';

void initSettingsFeature() {
  sl
    ..registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(sharedPreferences: sl()),
    )
    ..registerLazySingleton<ThemeSystemDataSource>(
      ThemeSystemDataSourceImpl.new,
    )
    ..registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl(sharedPreferences: sl()),
    )
    ..registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(localDataSource: sl(), systemDataSource: sl()),
    )
    ..registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton(() => GetThemeUseCase(sl()))
    ..registerLazySingleton(() => SaveThemeUseCase(sl()))
    ..registerLazySingleton(() => GetLanguageUseCase(sl()))
    ..registerLazySingleton(() => GetSystemThemeUseCase(sl()))
    ..registerLazySingleton(() => SaveLanguageUseCase(sl()))
    ..registerFactory(
      () => ThemeCubit(
        getThemeUseCase: sl(),
        saveThemeUseCase: sl(),
        getSystemThemeUseCase: sl(),
      ),
    )
    ..registerFactory(
      () => LanguageCubit(getLanguageUseCase: sl(), saveLanguageUseCase: sl()),
    );
}
