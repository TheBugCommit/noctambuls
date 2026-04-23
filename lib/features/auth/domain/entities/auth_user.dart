import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    required this.tokenExpiry,
  });

  final String id;
  final String email;
  final DateTime tokenExpiry;

  bool get isTokenExpired => DateTime.now().isAfter(tokenExpiry);

  @override
  List<Object?> get props => [id, email, tokenExpiry];
}
