import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];
}

final class ProfileUpdateRequested extends ProfileEvent {
  const ProfileUpdateRequested({
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
