import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/usecases/update_profile_usecase.dart';

abstract class ProfileRepository {
  Future<Result<UserProfile>> getProfile(String userId);
  Future<Result<UserProfile>> updateProfile(
    String userId,
    UpdateProfileParams params,
  );
}
