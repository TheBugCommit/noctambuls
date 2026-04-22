import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    required this.jwt,
  });

  final String id;
  final String email;
  final String jwt;

  @override
  List<Object?> get props => [id, email, jwt];
}
