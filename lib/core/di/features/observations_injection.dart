import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/features/observations/data/datasources/observation_local_datasource.dart';
import 'package:noctambuls/features/observations/data/repository/observation_repository_impl.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/get_active_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_observations_for_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/active_session_bloc.dart';

void initObservationsFeature() {
  // DataSources
  sl
    ..registerLazySingleton<ObservationLocalDataSource>(
      () => ObservationLocalDataSourceImpl(db: sl()),
    )
    // Repositories
    ..registerLazySingleton<ObservationRepository>(
      () => ObservationRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton(() => WatchActiveSessionUseCase(sl()))
    ..registerLazySingleton(() => GetActiveSessionUseCase(sl()))
    ..registerLazySingleton(() => WatchObservationsForSessionUseCase(sl()))
    ..registerLazySingleton(() => CreateSessionUseCase(sl()))
    ..registerLazySingleton(() => UpdateSessionUseCase(sl()))
    ..registerLazySingleton(() => AddObservationUseCase(sl()))
    ..registerLazySingleton(() => DeleteObservationUseCase(sl()))
    ..registerFactory(
      () => ActiveSessionBloc(
        watchActiveSessionUseCase: sl(),
        getActiveSessionUseCase: sl(),
        watchObservationsUseCase: sl(),
        createSessionUseCase: sl(),
        updateSessionUseCase: sl(),
        addObservationUseCase: sl(),
        deleteObservationUseCase: sl(),
      ),
    );
}
