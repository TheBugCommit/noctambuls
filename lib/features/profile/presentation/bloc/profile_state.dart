import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  UserProfile? get currentProfile => switch (this) {
    ProfileLoaded(profile: final p) => p,
    ProfileUpdating(profile: final p) => p,
    ProfileUpdateSuccess(profile: final p) => p,
    ProfileUpdateError(profile: final p) => p,
    _ => null,
  };

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required this.profile});

  final UserProfile profile;

  @override
  List<Object?> get props => [profile];
}

final class ProfileError extends ProfileState {
  const ProfileError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class ProfileUpdating extends ProfileState {
  const ProfileUpdating({required this.profile});

  final UserProfile profile;

  @override
  List<Object?> get props => [profile];
}

final class ProfileUpdateSuccess extends ProfileState {
  const ProfileUpdateSuccess({required this.profile});

  final UserProfile profile;

  @override
  List<Object?> get props => [profile];
}

final class ProfileUpdateError extends ProfileState {
  const ProfileUpdateError({required this.failure, required this.profile});

  final Failure failure;
  final UserProfile profile;

  @override
  List<Object?> get props => [failure, profile];
}
