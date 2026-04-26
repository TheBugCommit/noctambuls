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
