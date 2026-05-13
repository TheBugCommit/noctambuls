import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/observations/data/datasources/session_local_datasource.dart';
import 'package:noctambuls/features/observations/data/repositories/session_repository_impl.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';
import 'package:noctambuls/features/observations/domain/usecases/add_session_participant_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/change_session_date_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/create_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/delete_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/finish_and_lock_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/get_active_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/remove_session_participant_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/save_observation_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/stop_observation_phase_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_location_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/update_session_properties_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_active_session_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_all_sessions_usecase.dart';
import 'package:noctambuls/features/observations/domain/usecases/watch_session_by_id_usecase.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_bloc.dart';

void initObservationsFeature() {
  sl
    // DataSources
    ..registerLazySingleton<SessionLocalDataSource>(
      () => SessionLocalDataSourceImpl(dbManager: sl<UserDatabaseManager>()),
    )
    // Repositories
    ..registerLazySingleton<SessionRepository>(
      () => SessionRepositoryImpl(localDataSource: sl()),
    )
    // Use Cases — session
    ..registerLazySingleton(() => WatchActiveSessionUseCase(sl()))
    ..registerLazySingleton(() => GetActiveSessionUseCase(sl()))
    ..registerLazySingleton(() => WatchAllSessionsUseCase(sl()))
    ..registerLazySingleton(
      () => CreateSessionUseCase(
        observationRepository: sl(),
        locationService: sl(),
      ),
    )
    ..registerLazySingleton(() => UpdateSessionPropertiesUseCase(sl()))
    ..registerLazySingleton(() => DeleteSessionUseCase(sl()))
    // Use Cases — observation
    ..registerLazySingleton(() => DeleteObservationUseCase(sl()))
    ..registerLazySingleton(() => StopObservationPhaseUseCase(sl()))
    ..registerLazySingleton(() => FinishAndLockSessionUseCase(sl()))
    ..registerLazySingleton(() => ChangeSessionDateUseCase(sl()))
    ..registerLazySingleton(() => AddSessionParticipantUseCase(sl()))
    ..registerLazySingleton(() => RemoveSessionParticipantUseCase(sl()))
    ..registerLazySingleton(() => SaveObservationUseCase(sl()))
    ..registerLazySingleton(() => UpdateSessionLocationUseCase(sl()))
    ..registerLazySingleton(() => WatchSessionByIdUseCase(sl()))
    // BLoC
    ..registerFactory(
      () => ObservingSessionBloc(
        watchActiveSessionUseCase: sl(),
        createSessionUseCase: sl(),
        updateSessionUseCase: sl(),
        deleteSessionUseCase: sl(),
        stopObservationPhaseUseCase: sl(),
        changeSessionDateUseCase: sl(),
        getBirdsUseCase: sl(),
        deleteObservationUseCase: sl(),
        getLanguageUseCase: sl(),
        updateSessionLocationUseCase: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerFactory(
      () => ObservationFormBloc(
        getBirdsUseCase: sl<GetBirdsUseCase>(),
        saveObservationUseCase: sl(),
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
        updateSessionPropertiesUseCase: sl(),
        deleteSessionUseCase: sl(),
        finishAndLockSessionUseCase: sl(),
        addSessionParticipantUseCase: sl(),
        removeSessionParticipantUseCase: sl(),
        initialSession: session,
        watchSessionByIdUseCase: sl(),
        getBirdsUseCase: sl(),
        getLanguageUseCase: sl(),
      ),
    );
}
