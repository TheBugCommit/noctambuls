import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required String id,
    required String name,
    required String phone,
    required DateTime createdAt,
    String? ornithologistCode,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  factory UserProfileModel.fromEntity(UserProfile entity) => UserProfileModel(
    id: entity.id,
    name: entity.name,
    phone: entity.phone,
    ornithologistCode: entity.ornithologistCode,
    createdAt: entity.createdAt,
  );
}

extension UserProfileModelX on UserProfileModel {
  UserProfile toDomain() => UserProfile(
    id: id,
    name: name,
    phone: phone,
    ornithologistCode: ornithologistCode,
    createdAt: createdAt,
  );
}
