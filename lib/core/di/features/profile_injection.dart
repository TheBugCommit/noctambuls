import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:noctambuls/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:noctambuls/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:noctambuls/features/profile/domain/repositories/profile_repository.dart';
import 'package:noctambuls/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:noctambuls/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';

void initProfileFeature() {
  sl
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(dio: sl(instanceName: 'apiDio')),
    )
    ..registerLazySingleton<ProfileLocalDataSource>(
      () =>
          ProfileLocalDataSourceImpl(dbManager: sl<UserDatabaseManager>()),
    )
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remote: sl(), local: sl()),
    )
    ..registerLazySingleton(() => GetProfileUseCase(sl()))
    ..registerLazySingleton(() => UpdateProfileUseCase(sl()))
    ..registerFactory(
      () => ProfileBloc(
        getProfileUseCase: sl(),
        updateProfileUseCase: sl(),
      ),
    );
}
