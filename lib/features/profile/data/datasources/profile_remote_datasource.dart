import 'package:dio/dio.dart';
import 'package:noctambuls/features/profile/data/models/update_profile_request_model.dart';
import 'package:noctambuls/features/profile/data/models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getProfile(String userId);
  Future<UserProfileModel> updateProfile(
    String userId,
    UpdateProfileRequestModel body,
  );
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<UserProfileModel> getProfile(String userId) async {
    final response = await dio.get<dynamic>('/api/profile/$userId');
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException("Server response isn't a valid JSON");
    }
    return UserProfileModel.fromJson(data);
  }

  @override
  Future<UserProfileModel> updateProfile(
    String userId,
    UpdateProfileRequestModel body,
  ) async {
    final response = await dio.patch<dynamic>(
      '/api/profile/$userId',
      data: body.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException("Server response isn't a valid JSON");
    }
    return UserProfileModel.fromJson(data);
  }
}
