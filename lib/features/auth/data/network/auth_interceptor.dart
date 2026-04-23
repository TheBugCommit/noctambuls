import 'package:dio/dio.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/models/auth_user_model.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenLocalDataSource tokenLocalDataSource,
    required AuthRemoteDataSource authRemoteDataSource,
  })  : _tokenLocalDataSource = tokenLocalDataSource,
        _authRemoteDataSource = authRemoteDataSource;

  final TokenLocalDataSource _tokenLocalDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;

  // Assigned after construction to break the circular dependency with apiDio.
  late Dio dio;

  static const _retryKey = 'auth_interceptor_retry';
  static const _proactiveRefreshThreshold = Duration(minutes: 2);

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
          await _tryRefresh();
          accessToken = await _tokenLocalDataSource.getAccessToken();
        }
      } on FormatException {
        // Malformed token — attempt refresh anyway
        await _tryRefresh();
        accessToken = await _tokenLocalDataSource.getAccessToken();
      }
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
      final refreshed = await _tryRefresh();
      if (refreshed) {
        handler.resolve(await _retry(err.requestOptions));
        return;
      }
    }
    handler.next(err);
  }

  bool _isRetry(RequestOptions options) =>
      options.extra[_retryKey] == true;

  Future<bool> _tryRefresh() async {
    final refreshToken = await _tokenLocalDataSource.getRefreshToken();
    if (refreshToken == null) return false;
    try {
      final response = await _authRemoteDataSource.refreshTokens(refreshToken);
      await _tokenLocalDataSource.saveTokenPair(
        response.accessToken,
        response.refreshToken,
      );
      return true;
    } on Exception {
      return false;
    }
  }

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
