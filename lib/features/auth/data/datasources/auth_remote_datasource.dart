import 'package:dio/dio.dart';
import 'package:noctambuls/features/auth/data/models/auth_response_model.dart';
import 'package:noctambuls/features/auth/data/models/provider_auth_request_model.dart';
import 'package:noctambuls/features/auth/data/models/refresh_token_request_model.dart';
import 'package:noctambuls/features/auth/data/models/refresh_token_response_model.dart';
import 'package:noctambuls/features/auth/data/models/sign_up_request_model.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signInWithProvider(
    AuthProviderType provider,
    ProviderAuthRequestModel requestModel,
  );

  Future<AuthResponseModel> signUpWithProvider(
    AuthProviderType provider,
    SignUpRequestModel requestModel,
  );

  Future<RefreshTokenResponseModel> refreshTokens(
    RefreshTokenRequestModel requestModel,
  );

  Future<void> invalidateToken(RefreshTokenRequestModel requestModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  String _getSignInEndpoint(AuthProviderType provider) {
    return '/api/auth/${AuthProviderType.google.value}/signin';
  }

  String _getSignUpEndpoint(AuthProviderType provider) {
    return '/api/auth/${AuthProviderType.google.value}/signup';
  }

  @override
  Future<AuthResponseModel> signInWithProvider(
    AuthProviderType provider,
    ProviderAuthRequestModel requestModel,
  ) async {
    final endpoint = _getSignInEndpoint(provider);
    final response = await dio.post<dynamic>(
      endpoint,
      data: requestModel.toJson(),
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
  Future<AuthResponseModel> signUpWithProvider(
    AuthProviderType provider,
    SignUpRequestModel requestModel,
  ) async {
    final endpoint = _getSignUpEndpoint(provider);
    final response = await dio.post<dynamic>(
      endpoint,
      data: requestModel.toJson(),
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
  Future<RefreshTokenResponseModel> refreshTokens(
    RefreshTokenRequestModel requestModel,
  ) async {
    final response = await dio.post<dynamic>(
      '/api/token/refresh',
      data: requestModel.toJson(),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException(
        "Server response isn't a valid JSON",
      );
    }

    return RefreshTokenResponseModel.fromJson(data);
  }

  @override
  Future<void> invalidateToken(RefreshTokenRequestModel requestModel) async {
    await dio.post<void>(
      '/api/token/invalidate',
      data: requestModel.toJson(),
    );
  }
}
