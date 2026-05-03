import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileParams extends Equatable {
  const UpdateProfileParams({
    required this.userId,
    required this.name,
    required this.phone,
  });

  final String userId;
  final String name;
  final String phone;

  @override
  List<Object?> get props => [userId, name, phone];
}

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<UserProfile>> call(UpdateProfileParams params) =>
      _repository.updateProfile(params.userId, params);
}
