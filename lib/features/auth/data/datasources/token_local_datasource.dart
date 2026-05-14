import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenLocalDataSource {
  Future<void> saveTokenPair(String accessToken, String refreshToken);

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> deleteAllTokens();

  Future<void> savePhotoUrl(String? url);

  Future<String?> getPhotoUrl();

  Future<void> saveUserId(String? userId);

  Future<String?> getUserId();
}

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  const TokenLocalDataSourceImpl({required this.storage});

  final FlutterSecureStorage storage;

  static const _accessTokenKey = 'auth_access_token';
  static const _refreshTokenKey = 'auth_refresh_token';
  static const _photoUrlKey = 'auth_photo_url';
  static const _userIdKey = 'auth_user_id';

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
    await storage.delete(key: _photoUrlKey);
  }

  @override
  Future<void> savePhotoUrl(String? url) async {
    if (url == null) {
      await storage.delete(key: _photoUrlKey);
    } else {
      await storage.write(key: _photoUrlKey, value: url);
    }
  }

  @override
  Future<String?> getPhotoUrl() => storage.read(key: _photoUrlKey);

  @override
  Future<void> saveUserId(String? userId) =>
      storage.write(key: _userIdKey, value: userId);

  @override
  Future<String?> getUserId() => storage.read(key: _userIdKey);
}
