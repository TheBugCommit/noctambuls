import 'package:dio/dio.dart';
import 'package:noctambuls/features/auth/data/models/auth_response_model.dart';
import 'package:noctambuls/features/auth/data/models/provider_auth_request_model.dart';
import 'package:noctambuls/features/auth/data/models/refresh_token_request_model.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signInWithProvider(
    AuthProviderType provider,
    String idToken,
  );

  Future<AuthResponseModel> refreshTokens(String refreshToken);

  Future<void> invalidateToken(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  String _getEndpointForProvider(AuthProviderType provider) {
    switch (provider) {
      case AuthProviderType.google:
        return '/auth/google';
      case AuthProviderType.apple:
        return '/auth/apple';
      case AuthProviderType.email:
        return '/auth/local';
    }
  }

  @override
  Future<AuthResponseModel> signInWithProvider(
    AuthProviderType provider,
    String idToken,
  ) async {
    final endpoint = _getEndpointForProvider(provider);

    final response = await dio.post<dynamic>(
      endpoint,
      data: ProviderAuthRequestModel(idToken: idToken).toJson(),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException(
        "Server response isn't a valid JSON",
      );
    }

    return AuthResponseModel.fromJson(data);
  }

  @override
  Future<AuthResponseModel> refreshTokens(String refreshToken) async {
    final response = await dio.post<dynamic>(
      '/token/refresh',
      data: RefreshTokenRequestModel(refreshToken: refreshToken).toJson(),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException(
        "Server response isn't a valid JSON",
      );
    }

    return AuthResponseModel.fromJson(data);
  }

  @override
  Future<void> invalidateToken(String refreshToken) async {
    await dio.post<void>(
      '/token/invalidate',
      data: RefreshTokenRequestModel(refreshToken: refreshToken).toJson(),
    );
  }
}
