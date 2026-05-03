import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/presentation/navigation/router.dart';
import 'package:noctambuls/features/auth/data/datasources/account_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/google_auth_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/network/auth_interceptor.dart';
import 'package:noctambuls/features/auth/data/network/token_refresh_manager.dart';
import 'package:noctambuls/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/get_stored_auth_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';

void initAuthFeature() {
  sl
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<TokenLocalDataSource>(
      () => TokenLocalDataSourceImpl(storage: sl()),
    )
    ..registerLazySingleton(
      () => TokenRefreshManager(
        authRemoteDataSource: sl(),
        tokenLocalDataSource: sl(),
      ),
    )
    // authDio: no interceptors — used by auth endpoints only
    ..registerLazySingleton<Dio>(
      () => Dio()..options.baseUrl = EnvConfig.serverUrl,
      instanceName: 'authDio',
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: sl(instanceName: 'authDio')),
    )
    ..registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(
        tokenLocalDataSource: sl(),
        refreshManager: sl(),
        logger: sl<IAppLogger>(),
        onSessionExpired: () {
          sl<AuthBloc>().add(const SignOutRequested());
        },
      ),
    )
    // apiDio: includes AuthInterceptor for protected endpoints
    ..registerLazySingleton<Dio>(
      () {
        final interceptor = sl<AuthInterceptor>();
        final dio = Dio()
          ..options.baseUrl = EnvConfig.serverUrl
          ..interceptors.add(interceptor);
        interceptor.dio = dio;
        return dio;
      },
      instanceName: 'apiDio',
    )
    ..registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSourceImpl(dio: sl(instanceName: 'apiDio')),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl(),
        accountRemoteDataSource: sl(),
        tokenLocalDataSource: sl(),
        providers: {
          GoogleAuthCredentials: GoogleAuthDataSourceImpl(
            googleSignIn: GoogleSignIn(
              clientId: Platform.isIOS ? EnvConfig.iosClientId : null,
              serverClientId: EnvConfig.googleWebClientId,
            ),
          ),
        },
        refreshManager: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerLazySingleton(() => GetStoredAuthUseCase(sl()))
    ..registerLazySingleton(() => SignInUseCase(sl()))
    ..registerLazySingleton(() => SignUpUseCase(sl()))
    ..registerLazySingleton(() => SignOutUseCase(sl()))
    ..registerLazySingleton(() => DeleteAccountUseCase(sl()))
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        getStoredAuthUseCase: sl(),
        signInUseCase: sl(),
        signUpUseCase: sl(),
        signOutUseCase: sl(),
        deleteAccountUseCase: sl(),
        dbManager: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerLazySingleton<GoRouter>(
      () => makeRouter(sl<AuthBloc>()),
    );
}
