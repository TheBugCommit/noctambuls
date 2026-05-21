import 'package:dio/dio.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/features/censuses/data/datasources/census_local_datasource.dart';
import 'package:noctambuls/features/censuses/data/datasources/census_remote_datasource.dart';
import 'package:noctambuls/features/censuses/data/repositories/census_repository_impl.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/censuses/domain/usecases/abandon_census_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/fetch_censuses_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/get_census_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/join_census_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/watch_censuses_usecase.dart';
import 'package:noctambuls/features/censuses/domain/usecases/whatch_joined_census_usecase.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_bloc.dart';

void initCensusesFeature() {
  sl
    // DataSources
    ..registerLazySingleton<CensusLocalDataSource>(
      () => CensusLocalDataSourceImpl(dbManager: sl<UserDatabaseManager>()),
    )
    ..registerLazySingleton<CensusRemoteDataSource>(
      () => CensusRemoteDataSourceImpl(dio: sl<Dio>(instanceName: 'apiDio')),
    )
    // Repository
    ..registerLazySingleton<CensusRepository>(
      () => CensusRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
      ),
    )
    // Use Cases
    ..registerLazySingleton(() => WatchCensusesUseCase(sl()))
    ..registerLazySingleton(() => GetCensusUseCase(sl()))
    ..registerLazySingleton(() => FetchCensusesUseCase(sl()))
    ..registerLazySingleton(() => AbandonCensusUseCase(sl()))
    ..registerLazySingleton(
      () => JoinCensusUseCase(sl(), sl(), EnvConfig.censusJwtPublicKey),
    )
    ..registerLazySingleton(() => WatchJoinedCensusUseCase(sl()))
    // BLoC
    ..registerFactory(
      () => CensusBloc(
        watchCensusesUseCase: sl(),
        joinCensusUseCase: sl(),
        abandonCensusUseCase: sl(),
        fetchCensusesUseCase: sl(),
        watchJoinedCensusUseCase: sl(),
        createSessionUseCase: sl(),
      ),
    );
}
