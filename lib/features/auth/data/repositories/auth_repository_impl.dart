import 'package:dio/dio.dart';
import 'package:noctambuls/core/data/error/dio_error_extension.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/auth/data/datasources/account_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_provider_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/models/auth_user_model.dart';
import 'package:noctambuls/features/auth/data/models/provider_auth_request_model.dart';
import 'package:noctambuls/features/auth/data/models/refresh_token_request_model.dart';
import 'package:noctambuls/features/auth/data/models/sign_up_request_model.dart';
import 'package:noctambuls/features/auth/data/network/token_refresh_manager.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_up_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.accountRemoteDataSource,
    required this.tokenLocalDataSource,
    required this.refreshManager,
    required Map<Type, AuthProviderDataSource> providers,
    required this.logger,
  }) : _providers = providers;

  final AuthRemoteDataSource remoteDataSource;
  final AccountRemoteDataSource accountRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;
  final TokenRefreshManager refreshManager;
  final IAppLogger logger;
  final Map<Type, AuthProviderDataSource> _providers;

  @override
  Future<Result<AuthUser>> signIn(AuthCredentials credentials) async {
    String? idToken;
    try {
      final provider = _providers[credentials.runtimeType];
      if (provider == null) return const Err(UnsupportedProviderFailure());

      idToken = await provider.authenticate(credentials);
      if (idToken == null) {
        return const Err(SignInCancelledFailure());
      }

      final photoUrl = await provider.getPhotoUrl();
      await tokenLocalDataSource.savePhotoUrl(photoUrl);

      final response = await remoteDataSource.signInWithProvider(
        provider.authProviderType,
        ProviderAuthRequestModel(idToken: idToken),
      );
      await tokenLocalDataSource.saveTokenPair(
        response.accessToken,
        response.refreshToken,
      );

      final authUser = AuthUserModel.fromJwt(
        response.accessToken,
        photoUrl: photoUrl,
      ).toDomain();

      await tokenLocalDataSource.saveUserId(authUser.id);
      return Ok(authUser);
    } on DioException catch (e, st) {
      if (e.isNetworkError || e.isInfrastructureError) {
        return Err(const NetworkFailure().withDebug(e, st));
      }

      final code = e.response!.statusCode!;
      if (code == 404 && e.isOurBackendError && idToken != null) {
        final provider = _providers[credentials.runtimeType]!;
        return Err(
          UserNotRegisteredFailure(
            idToken: idToken,
            providerType: provider.authProviderType,
          ).withDebug(e, st),
        );
      }

      return Err(SignInFailure(statusCode: code).withDebug(e, st));
    } catch (e, st) {
      return Err(const BackendAuthFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<AuthUser>> signUp(
    SignUpParams params,
  ) async {
    try {
      final response = await remoteDataSource.signUpWithProvider(
        params.provider,
        SignUpRequestModel(
          idToken: params.idToken,
          name: params.name,
          phone: params.phone,
        ),
      );

      await tokenLocalDataSource.saveTokenPair(
        response.accessToken,
        response.refreshToken,
      );

      final provider = _providers.values
          .where(
            (p) => p.authProviderType == params.provider,
          )
          .firstOrNull;
      final photoUrl = await provider?.getPhotoUrl();
      await tokenLocalDataSource.savePhotoUrl(photoUrl);
      final authUser = AuthUserModel.fromJwt(
        response.accessToken,
        photoUrl: photoUrl,
      ).toDomain();

      await tokenLocalDataSource.saveUserId(authUser.id);
      return Ok(authUser);
    } on DioException catch (e, st) {
      if (e.response == null) {
        return Err(const NetworkFailure().withDebug(e, st));
      }

      final code = e.response!.statusCode!;
      if (code == 401) {
        return Err(const ProviderTokenExpiredFailure().withDebug(e, st));
      }

      return code >= 500
          ? Err(BackendAuthFailure(statusCode: code).withDebug(e, st))
          : Err(SignUpFailure(statusCode: code).withDebug(e, st));
    } catch (e, st) {
      return Err(const BackendAuthFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<AuthUser>> getStoredAuth() async {
    AuthUser? expiredUser;

    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      final photoUrl = await tokenLocalDataSource.getPhotoUrl();

      if (accessToken != null) {
        try {
          expiredUser = AuthUserModel.fromJwt(
            accessToken,
            photoUrl: photoUrl,
          ).toDomain();

          if (!expiredUser.isTokenExpired) {
            return Ok(expiredUser);
          }
        } on FormatException catch (e, st) {
          logger.failure(const InvalidTokenFailure().withDebug(e, st));
        }
      }

      final newToken = await refreshManager.refreshToken();

      if (newToken != null) {
        return Ok(
          AuthUserModel.fromJwt(newToken, photoUrl: photoUrl).toDomain(),
        );
      } else {
        return const Err(InvalidTokenFailure());
      }
    } on DioException catch (e, st) {
      if (e.isNetworkError || e.isInfrastructureError) {
        if (expiredUser != null) {
          return Ok(expiredUser);
        }
        return Err(const NetworkFailure().withDebug(e, st));
      }

      return Err(const RefreshTokenFailure().withDebug(e, st));
    } catch (e, st) {
      return Err(const TokenStorageFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> signOut() async {
    try {
      final refreshToken = await tokenLocalDataSource.getRefreshToken();
      if (refreshToken != null) {
        try {
          await remoteDataSource.invalidateToken(
            RefreshTokenRequestModel(refreshToken: refreshToken),
          );
        } on Exception {
          // Network errors are silently ignored — token expires naturally
        }
      }

      await tokenLocalDataSource.deleteAllTokens();

      for (final provider in _providers.values) {
        await provider.signOut();
      }

      return const Ok(Unit.instance);
    } catch (e, st) {
      final failure = const TokenStorageFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }

  @override
  Future<Result<Unit>> deleteAccount() async {
    try {
      await accountRemoteDataSource.deleteAccount();
      await tokenLocalDataSource.deleteAllTokens();
      for (final provider in _providers.values) {
        await provider.signOut();
      }
      return const Ok(Unit.instance);
    } on DioException catch (e, st) {
      final code = e.response?.statusCode ?? 400;
      return Err(DeleteAccountFailure(statusCode: code).withDebug(e, st));
    } catch (e, st) {
      return Err(const DeleteAccountFailure().withDebug(e, st));
    }
  }
}
