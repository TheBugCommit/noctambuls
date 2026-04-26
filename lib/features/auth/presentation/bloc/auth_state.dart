import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state while checking secure storage on app startup.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Sign-in or sign-out operation in progress.
final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class Authenticated extends AuthState {
  const Authenticated({required this.user});

  final AuthUser user;

  @override
  List<Object?> get props => [user];
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();
}

final class AuthError extends AuthState {
  const AuthError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
