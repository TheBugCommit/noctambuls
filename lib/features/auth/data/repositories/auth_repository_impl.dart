import 'package:dio/dio.dart';
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

      final response = await remoteDataSource.signInWithGoogle(externalToken);
      await tokenLocalDataSource.saveTokenPair(
        response.accessToken,
        response.refreshToken,
      );
      return Ok(AuthUserModel.fromJwt(response.accessToken));
    } on Exception catch (e, st) {
      return Err(const BackendAuthFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<AuthUser?>> getStoredAuth() async {
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
    } on Exception catch (e, st) {
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
    } on Exception catch (e, st) {
      final failure = const TokenStorageFailure().withDebug(e, st);
      AppLogger.failure(failure);
      return Err(failure);
    }
  }

  /// Attempts to refresh the access token using the stored refresh token.
  ///
  /// If offline ([DioException] with no response), returns [Ok] with
  /// [expiredUser] so the app stays functional without network.
  /// If [expiredUser] is null and offline, returns [Ok(null)] (no session).
  Future<Result<AuthUser?>> _refreshWithFallback({
    required AuthUserModel? expiredUser,
  }) async {
    final refreshToken = await tokenLocalDataSource.getRefreshToken();
    if (refreshToken == null) return const Ok(null);

    try {
      final response = await remoteDataSource.refreshTokens(refreshToken);
      await tokenLocalDataSource.saveTokenPair(
        response.accessToken,
        response.refreshToken,
      );
      return Ok(AuthUserModel.fromJwt(response.accessToken));
    } on DioException catch (e, st) {
      // No response means network error — go offline if possible
      if (e.response == null) {
        if (expiredUser != null) return Ok(expiredUser);
        return const Ok(null);
      }
      // Server responded with an auth error — refresh token is invalid
      AppLogger.failure(const InvalidTokenFailure().withDebug(e, st));
      await tokenLocalDataSource.deleteAllTokens();
      return Err(const InvalidTokenFailure().withDebug(e, st));
    } on Exception catch (e, st) {
      await tokenLocalDataSource.deleteAllTokens();
      return Err(const InvalidTokenFailure().withDebug(e, st));
    }
  }
}
