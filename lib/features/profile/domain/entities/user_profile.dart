import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.createdAt,
    this.ornithologistCode,
  });

  final String id;
  final String name;
  final String phone;
  final String? ornithologistCode;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, phone, ornithologistCode, createdAt];
}
