import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class CheckStoredAuth extends AuthEvent {
  const CheckStoredAuth();
}

final class SignInWithGoogleRequested extends AuthEvent {
  const SignInWithGoogleRequested();
}

final class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

final class SignUpRequested extends AuthEvent {
  const SignUpRequested({required this.name, required this.phone});

  final String name;
  final String phone;

  @override
  List<Object?> get props => [name, phone];
}
