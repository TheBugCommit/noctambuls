import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/features/observations/data/datasources/observation_local_datasource.dart';
import 'package:noctambuls/features/observations/data/repositories/observation_repository_impl.dart';
import 'package:noctambuls/features/observations/domain/repositories/observation_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/get_active_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_all_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_observations_for_session_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/active_session_bloc.dart';

void initObservationsFeature() {
  sl
    // DataSources
    ..registerLazySingleton<ObservationLocalDataSource>(
      () => ObservationLocalDataSourceImpl(db: sl()),
    )
    // Repositories
    ..registerLazySingleton<ObservationRepository>(
      () => ObservationRepositoryImpl(localDataSource: sl()),
    )
    // Use Cases — session
    ..registerLazySingleton(() => WatchActiveSessionUseCase(sl()))
    ..registerLazySingleton(() => GetActiveSessionUseCase(sl()))
    ..registerLazySingleton(() => WatchAllSessionsUseCase(sl()))
    ..registerLazySingleton(() => CreateSessionUseCase(sl()))
    ..registerLazySingleton(() => UpdateSessionUseCase(sl()))
    ..registerLazySingleton(() => DeleteSessionUseCase(sl()))
    // Use Cases — observation
    ..registerLazySingleton(() => WatchObservationsForSessionUseCase(sl()))
    ..registerLazySingleton(() => AddObservationUseCase(sl()))
    ..registerLazySingleton(() => UpdateObservationUseCase(sl()))
    ..registerLazySingleton(() => DeleteObservationUseCase(sl()))
    // BLoC
    ..registerFactory(
      () => ActiveSessionBloc(
        watchActiveSessionUseCase: sl(),
        getActiveSessionUseCase: sl(),
        watchObservationsUseCase: sl(),
        createSessionUseCase: sl(),
        updateSessionUseCase: sl(),
        addObservationUseCase: sl(),
        deleteObservationUseCase: sl(),
        deleteSessionUseCase: sl(),
      ),
    );
}
