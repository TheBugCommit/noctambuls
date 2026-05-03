import 'package:dio/dio.dart';
import 'package:noctambuls/core/error/dio_error_extension.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:noctambuls/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:noctambuls/features/profile/data/models/update_profile_request_model.dart';
import 'package:noctambuls/features/profile/data/models/user_profile_model.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/failures/profile_failures.dart';
import 'package:noctambuls/features/profile/domain/repositories/profile_repository.dart';
import 'package:noctambuls/features/profile/domain/usecases/update_profile_usecase.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required this.remote,
    required this.local,
  });

  final ProfileRemoteDataSource remote;
  final ProfileLocalDataSource local;

  @override
  Future<Result<UserProfile>> getProfile(String userId) async {
    try {
      final localProfile = await local.getProfile(userId);

      if (localProfile != null) {
        return Ok(localProfile.toDomain());
      }

      final remoteProfile = await remote.getProfile(userId);

      await local.saveProfile(remoteProfile);

      return Ok(remoteProfile.toDomain());
    } on DioException catch (e, st) {
      if (e.isNetworkError || e.isInfrastructureError) {
        return Err(const ProfileNetworkFailure().withDebug(e, st));
      }
      final code = e.response?.statusCode ?? 0;
      if (code == 404) {
        return Err(const ProfileNotFoundFailure().withDebug(e, st));
      }
      return Err(ProfileNetworkFailure(statusCode: code).withDebug(e, st));
    } catch (e, st) {
      return Err(const ProfileNetworkFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<UserProfile>> updateProfile(
    String userId,
    UpdateProfileParams params,
  ) async {
    try {
      final model = await remote.updateProfile(
        userId,
        UpdateProfileRequestModel(name: params.name, phone: params.phone),
      );
      await local.saveProfile(model);
      return Ok(model.toDomain());
    } on DioException catch (e, st) {
      if (e.isNetworkError || e.isInfrastructureError) {
        return Err(const ProfileNetworkFailure().withDebug(e, st));
      }
      final code = e.response?.statusCode ?? 0;
      return Err(ProfileUpdateFailure(statusCode: code).withDebug(e, st));
    } catch (e, st) {
      return Err(const ProfileUpdateFailure().withDebug(e, st));
    }
  }
}
