import 'package:dio/dio.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_provider_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/models/auth_user_model.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenLocalDataSource,
    required Map<Type, AuthProviderDataSource> providers,
  }) : _providers = providers;

  final AuthRemoteDataSource remoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;
  final Map<Type, AuthProviderDataSource> _providers;

  @override
  Future<Result<AuthUser>> signIn(AuthCredentials credentials) async {
    try {
      final provider = _providers[credentials.runtimeType];
      if (provider == null) return const Err(UnsupportedProviderFailure());

      final externalToken = await provider.authenticate(credentials);
      if (externalToken == null) {
        return const Err(SignInCancelledFailure());
      }

      final response = await remoteDataSource.signInWithProvider(
        provider.authProviderType,
        externalToken,
      );
      await tokenLocalDataSource.saveTokenPair(
        response.accessToken,
        response.refreshToken,
      );
      return Ok(AuthUserModel.fromJwt(response.accessToken));
    } on DioException catch (e, st) {
      if (e.response == null) {
        return Err(const NetworkFailure().withDebug(e, st));
      }
      final code = e.response!.statusCode!;
      return code >= 500
          ? Err(BackendAuthFailure(statusCode: code).withDebug(e, st))
          : Err(SignInFailure(statusCode: code).withDebug(e, st));
    } catch (e, st) {
      return Err(const BackendAuthFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<AuthUser>> getStoredAuth() async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();

      if (accessToken == null) {
        return _refreshWithFallback(expiredUser: null);
      }

      AuthUserModel user;
      try {
        user = AuthUserModel.fromJwt(accessToken);
      } on FormatException catch (e, st) {
        AppLogger.failure(const InvalidTokenFailure().withDebug(e, st));
        return _refreshWithFallback(expiredUser: null);
      }

      if (!user.isTokenExpired) {
        return Ok(user);
      }

      return _refreshWithFallback(expiredUser: user);
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
          await remoteDataSource.invalidateToken(refreshToken);
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
      AppLogger.failure(failure);
      return Err(failure);
    }
  }

  /// Attempts to refresh the access token using the stored refresh token.
  Future<Result<AuthUser>> _refreshWithFallback({
    required AuthUserModel? expiredUser,
  }) async {
    final refreshToken = await tokenLocalDataSource.getRefreshToken();
    if (refreshToken == null) return const Err(InvalidTokenFailure());

    try {
      final response = await remoteDataSource.refreshTokens(refreshToken);
      await tokenLocalDataSource.saveTokenPair(
        response.accessToken,
        response.refreshToken,
      );
      return Ok(AuthUserModel.fromJwt(response.accessToken));
    } on DioException catch (e, st) {
      // No response means network error — go offline if possible
      if (e.response == null && expiredUser == null) {
        return const Err(NetworkFailure());
      } else if (expiredUser != null && e.response == null) {
        return Ok(expiredUser);
      }

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        AppLogger.failure(const InvalidTokenFailure().withDebug(e, st));
        await tokenLocalDataSource.deleteAllTokens();
        return Err(const InvalidTokenFailure().withDebug(e, st));
      }

      if (e.response?.statusCode != null && e.response!.statusCode! >= 500) {
        return Err(
          BackendAuthFailure(
            statusCode: e.response!.statusCode,
          ).withDebug(e, st),
        );
      }

      if (expiredUser != null) {
        return Ok(expiredUser);
      } else {
        return const Err(RefreshTokenFailure());
      }
    } catch (e, st) {
      return Err(const BackendAuthFailure().withDebug(e, st));
    }
  }
}
