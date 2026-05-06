import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/data/datasources/observation_local_datasource.dart';
import 'package:noctambuls/features/observations/data/repositories/observation_repository_impl.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
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
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_bloc.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';

void initObservationsFeature() {
  sl
    // DataSources
    ..registerLazySingleton<ObservationLocalDataSource>(
      () =>
          ObservationLocalDataSourceImpl(dbManager: sl<UserDatabaseManager>()),
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
      () => SessionLifecycleBloc(
        watchActiveSessionUseCase: sl(),
        createSessionUseCase: sl(),
        updateSessionUseCase: sl(),
        deleteSessionUseCase: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerFactory(
      () => ObservationFormBloc(
        getBirdsUseCase: sl<GetBirdsUseCase>(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerFactoryParam<SessionObservationBloc, String, void>(
      (sessionId, _) => SessionObservationBloc(
        sessionId: sessionId,
        watchObservationsUseCase: sl(),
        addObservationUseCase: sl(),
        updateObservationUseCase: sl(),
        deleteObservationUseCase: sl(),
        getBirdsUseCase: sl<GetBirdsUseCase>(),
        getLanguageUseCase: sl<GetLanguageUseCase>(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerFactory(
      () => SessionListBloc(
        watchAllSessionsUseCase: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerFactoryParam<SessionReviewBloc, ObservationSession, void>(
      (session, _) => SessionReviewBloc(
        updateSessionUseCase: sl(),
        deleteSessionUseCase: sl(),
        initialSession: session,
      ),
    );
}
