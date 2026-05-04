import 'package:dio/dio.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/data/datasources/audio_preferences_local_datasource.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_local_datasource.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_remote_datasource.dart';
import 'package:noctambuls/features/guide/data/repositories/audio_preferences_repository_impl.dart';
import 'package:noctambuls/features/guide/data/repositories/birds_repository_impl.dart';
import 'package:noctambuls/features/guide/data/services/catalog_media_service.dart';
import 'package:noctambuls/features/guide/domain/repositories/audio_preferences_repository.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';
import 'package:noctambuls/features/guide/domain/usecases/accept_aud_warning_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/check_audio_warning_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/check_is_catalog_empty_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/sync_catalog_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void initGuideFeature() {
  sl
    ..registerLazySingleton<BirdsLocalDataSource>(
      () => BirdsLocalDataSourceDriftImpl(db: sl()),
    )
    ..registerLazySingleton<BirdsRemoteDataSource>(
      () => BirdsRemoteDataSourceImpl(dio: sl<Dio>(instanceName: 'apiDio')),
    )
    ..registerLazySingleton<AudioPreferencesLocalDataSource>(
      () => AudioPreferencesLocalDataSourceImpl(prefs: sl<SharedPreferences>()),
    )
    ..registerLazySingleton<AudioPreferencesRepository>(
      () => AudioPreferencesRepositoryImpl(
        localDataSource: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerLazySingleton<CatalogMediaService>(
      () => CatalogMediaService(
        dio: sl<Dio>(instanceName: 'apiDio'),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerLazySingleton<BirdsRepository>(
      () => BirdsRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        mediaService: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerLazySingleton(() => GetBirdsUseCase(sl()))
    ..registerLazySingleton(() => SyncCatalogUseCase(sl()))
    ..registerLazySingleton(() => CheckIsCatalogEmptyUseCase(sl()))
    ..registerLazySingleton(() => CheckAudioWarningUseCase(sl()))
    ..registerLazySingleton(() => AcceptAudioWarningUseCase(sl()))
    ..registerFactory(
      () => GuideBloc(
        getBirdsUseCase: sl(),
        logger: sl<IAppLogger>(),
        acceptAudioWarningUseCase: sl(),
        checkAudioWarningUseCase: sl(),
      ),
    )
    ..registerFactory(
      () => CatalogSyncBloc(
        syncCatalogUseCase: sl(),
        checkIsCatalogEmptyUseCase: sl(),
        logger: sl<IAppLogger>(),
      ),
    );
}
