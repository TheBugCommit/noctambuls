import 'package:dio/dio.dart';
import 'package:noctambuls/features/auth/data/models/auth_response_model.dart';
import 'package:noctambuls/features/auth/data/models/google_auth_request_model.dart';
import 'package:noctambuls/features/auth/data/models/refresh_token_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signInWithGoogle(String idToken);

  Future<AuthResponseModel> refreshTokens(String refreshToken);

  Future<void> invalidateToken(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<AuthResponseModel> signInWithGoogle(String idToken) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/auth/google',
      data: GoogleAuthRequestModel(idToken: idToken).toJson(),
    );
    return AuthResponseModel.fromJson(response.data!);
  }

  @override
  Future<AuthResponseModel> refreshTokens(String refreshToken) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/token/refresh',
      data: RefreshTokenRequestModel(refreshToken: refreshToken).toJson(),
    );
    return AuthResponseModel.fromJson(response.data!);
  }

  @override
  Future<void> invalidateToken(String refreshToken) async {
    await dio.post<void>(
      '/token/invalidate',
      data: RefreshTokenRequestModel(refreshToken: refreshToken).toJson(),
    );
  }
}
