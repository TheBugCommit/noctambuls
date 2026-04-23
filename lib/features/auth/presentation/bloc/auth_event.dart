import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_credentials.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class CheckStoredAuth extends AuthEvent {
  const CheckStoredAuth();
}

final class SignInRequested extends AuthEvent {
  const SignInRequested(this.credentials);

  final AuthCredentials credentials;

  @override
  List<Object> get props => [credentials];
}

final class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}
