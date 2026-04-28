import 'package:dio/dio.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';

class TokenRefreshManager {
  TokenRefreshManager({
    required this.tokenLocalDataSource,
    required this.authRemoteDataSource,
  });

  final TokenLocalDataSource tokenLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  // Guarda la petició de refresc en curs per evitar trucades concurrents
  Future<String?>? _refreshFuture;

  /// Retorna el nou Access Token si té èxit.
  /// Retorna null si el Refresh Token ha expirat/és invàlid.
  /// Llença una excepció (DioException) si hi ha un error de xarxa/servidor.
  Future<String?> refreshToken() async {
    if (_refreshFuture != null) {
      return _refreshFuture;
    }

    _refreshFuture = _performRefresh();
    try {
      final result = await _refreshFuture;
      return result;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<String?> _performRefresh() async {
    final refreshToken = await tokenLocalDataSource.getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await authRemoteDataSource.refreshTokens(refreshToken);
      await tokenLocalDataSource.saveTokenPair(
        response.accessToken,
        response.refreshToken,
      );
      return response.accessToken;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await tokenLocalDataSource.deleteAllTokens();
        return null;
      }
      rethrow;
    }
  }
}
