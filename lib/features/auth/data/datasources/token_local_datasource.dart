import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenLocalDataSource {
  Future<void> saveTokenPair(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> deleteAllTokens();
}

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  const TokenLocalDataSourceImpl({required this.storage});

  final FlutterSecureStorage storage;

  static const _accessTokenKey = 'auth_access_token';
  static const _refreshTokenKey = 'auth_refresh_token';

  @override
  Future<void> saveTokenPair(String accessToken, String refreshToken) async {
    await storage.write(key: _accessTokenKey, value: accessToken);
    await storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @override
  Future<String?> getAccessToken() => storage.read(key: _accessTokenKey);

  @override
  Future<String?> getRefreshToken() => storage.read(key: _refreshTokenKey);

  @override
  Future<void> deleteAllTokens() async {
    await storage.delete(key: _accessTokenKey);
    await storage.delete(key: _refreshTokenKey);
  }
}
