import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/settings/data/datasources/language_local_datasource.dart';
import 'package:noctambuls/features/settings/data/datasources/notification_settings_local_datasource.dart';
import 'package:noctambuls/features/settings/data/datasources/theme_local_datasource.dart';
import 'package:noctambuls/features/settings/data/datasources/theme_system_datasource.dart';
import 'package:noctambuls/features/settings/data/repositories/language_repository_impl.dart';
import 'package:noctambuls/features/settings/data/repositories/notification_settings_repository_impl.dart';
import 'package:noctambuls/features/settings/data/repositories/theme_repository_impl.dart';
import 'package:noctambuls/features/settings/domain/repositories/language_repository.dart';
import 'package:noctambuls/features/settings/domain/repositories/notification_settings_repository.dart';
import 'package:noctambuls/features/settings/domain/repositories/theme_repository.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_notifications_enabled_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_system_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_theme_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_notifications_enabled_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_theme_usecase.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/notification_settings_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_bloc.dart';

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
    ..registerLazySingleton<NotificationSettingsLocalDataSource>(
      () => NotificationSettingsLocalDataSourceImpl(sharedPreferences: sl()),
    )
    ..registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(localDataSource: sl(), systemDataSource: sl()),
    )
    ..registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton<NotificationSettingsRepository>(
      () => NotificationSettingsRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton(() => GetThemeUseCase(sl()))
    ..registerLazySingleton(() => SaveThemeUseCase(sl()))
    ..registerLazySingleton(() => GetLanguageUseCase(sl()))
    ..registerLazySingleton(() => GetSystemThemeUseCase(sl()))
    ..registerLazySingleton(() => SaveLanguageUseCase(sl()))
    ..registerLazySingleton(() => GetNotificationsEnabledUseCase(sl()))
    ..registerLazySingleton(() => SaveNotificationsEnabledUseCase(sl()))
    ..registerFactory(
      () => ThemeBloc(
        getThemeUseCase: sl(),
        saveThemeUseCase: sl(),
        getSystemThemeUseCase: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerFactory(
      () => LanguageBloc(
        getLanguageUseCase: sl(),
        saveLanguageUseCase: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerFactory(
      () => NotificationSettingsBloc(
        getEnabledUseCase: sl(),
        saveEnabledUseCase: sl(),
        logger: sl<IAppLogger>(),
      ),
    );
}
