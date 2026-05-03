import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  const GetProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<UserProfile>> call(String userId) =>
      _repository.getProfile(userId);
}
