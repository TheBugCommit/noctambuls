import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/models/auth_user_model.dart';
import 'package:noctambuls/features/auth/data/network/token_refresh_manager.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenLocalDataSource tokenLocalDataSource,
    required TokenRefreshManager refreshManager,
    required this.onSessionExpired,
    required this.logger,
  }) : _tokenLocalDataSource = tokenLocalDataSource,
       _refreshManager = refreshManager;

  final TokenLocalDataSource _tokenLocalDataSource;
  final TokenRefreshManager _refreshManager;
  final VoidCallback onSessionExpired;
  final IAppLogger logger;

  // Assigned after construction to break the circular dependency with apiDio.
  late Dio dio;

  static const _retryKey = 'auth_interceptor_retry';
  static const _proactiveRefreshThreshold = Duration(minutes: 5);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var accessToken = await _tokenLocalDataSource.getAccessToken();

    if (accessToken != null && !_isRetry(options)) {
      try {
        final user = AuthUserModel.fromJwt(accessToken);
        final timeUntilExpiry = user.tokenExpiry.difference(DateTime.now());
        if (timeUntilExpiry < _proactiveRefreshThreshold) {
          final newToken = await _refreshManager.refreshToken();
          if (newToken != null) accessToken = newToken;
        }
      } on FormatException {
        final newToken = await _refreshManager.refreshToken();
        if (newToken != null) accessToken = newToken;
      } catch (e, st) {
        logger.failure(const NetworkFailure().withDebug(e, st));
      } // Ignore Network errors
    }

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isRetry(err.requestOptions)) {
      try {
        final newToken = await _refreshManager.refreshToken();
        if (newToken != null) {
          handler.resolve(await _retry(err.requestOptions));
          return;
        } else {
          onSessionExpired();
        }
      } catch (e, st) {
        logger.failure(const NetworkFailure().withDebug(e, st));
      }
    }

    handler.next(err);
  }

  bool _isRetry(RequestOptions options) => options.extra[_retryKey] == true;

  Future<Response<dynamic>> _retry(RequestOptions options) async {
    final newToken = await _tokenLocalDataSource.getAccessToken();
    return dio.fetch<dynamic>(
      options.copyWith(
        headers: {
          ...options.headers,
          if (newToken != null) 'Authorization': 'Bearer $newToken',
        },
        extra: {...options.extra, _retryKey: true},
      ),
    );
  }
}
