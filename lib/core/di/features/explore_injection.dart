import 'package:dio/dio.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/domain/usecases/connectivity/check_internet_connection_usecase.dart';
import 'package:noctambuls/features/explore/data/datasources/explore_local_datasource.dart';
import 'package:noctambuls/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:noctambuls/features/explore/data/repositories/explore_repository_impl.dart';
import 'package:noctambuls/features/explore/domain/repositories/explore_repository.dart';
import 'package:noctambuls/features/explore/domain/service/map_clustering_service.dart';
import 'package:noctambuls/features/explore/domain/usecases/sync_map_bubbles_usecase.dart';
import 'package:noctambuls/features/explore/domain/usecases/watch_map_bubbles_usecase.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';

void initExploreFeature() {
  sl
    ..registerLazySingleton<ExploreLocalDataSource>(
      () => ExploreLocalDataSourceImpl(appDb: sl<AppDatabase>()),
    )
    ..registerLazySingleton<ExploreRemoteDataSource>(
      () => ExploreRemoteDataSourceImpl(
        dio: sl<Dio>(instanceName: 'apiDio'),
      ),
    )
    ..registerLazySingleton<ExploreRepository>(
      () => ExploreRepositoryImpl(
        local: sl(),
        remote: sl(),
      ),
    )
    ..registerLazySingleton(() => WatchMapBubblesUseCase(sl()))
    ..registerLazySingleton(() => SyncMapBubblesUseCase(sl()))
    ..registerLazySingleton(MapClusteringService.new)
    ..registerFactory(
      () => ExploreBloc(
        watchBubbles: sl(),
        syncBubbles: sl(),
        getBirds: sl<GetBirdsUseCase>(),
        checkInternet: sl<CheckInternetConnectionUseCase>(),
        clusteringService: sl(),
      ),
    );
}
