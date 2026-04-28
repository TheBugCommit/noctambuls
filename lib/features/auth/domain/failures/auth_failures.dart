import 'package:noctambuls/core/error/failure.dart';

sealed class AuthFailure extends Failure {
  const AuthFailure({
    required super.debugMessage,
    required super.statusCode,
    super.stackTrace,
  });
}

final class SignInCancelledFailure extends AuthFailure {
  const SignInCancelledFailure({
    super.debugMessage = 'Sign-in was cancelled by the user',
    super.statusCode = 0,
    super.stackTrace,
  });

  @override
  SignInCancelledFailure withDebug(
    Object error, [
    StackTrace? stackTrace,
  ]) => SignInCancelledFailure(
    debugMessage: error.toString(),
    statusCode: statusCode,
    stackTrace: stackTrace,
  );
}

final class SignInFailure extends AuthFailure {
  const SignInFailure({
    super.debugMessage = 'Sign-in failed',
    super.statusCode = 400,
    super.stackTrace,
  });

  @override
  SignInFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      SignInFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class BackendAuthFailure extends AuthFailure {
  const BackendAuthFailure({
    super.debugMessage = 'Backend authentication failed',
    int? statusCode,
    super.stackTrace,
  }) : super(statusCode: statusCode ?? 400);

  @override
  BackendAuthFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      BackendAuthFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class TokenStorageFailure extends AuthFailure {
  const TokenStorageFailure({
    super.debugMessage = 'Failed to access secure token storage',
    super.statusCode = 503,
    super.stackTrace,
  });

  @override
  TokenStorageFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      TokenStorageFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class InvalidTokenFailure extends AuthFailure {
  const InvalidTokenFailure({
    super.debugMessage = 'Stored JWT is expired or malformed',
    super.statusCode = 401,
    super.stackTrace,
  });

  @override
  InvalidTokenFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      InvalidTokenFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class UnsupportedProviderFailure extends AuthFailure {
  const UnsupportedProviderFailure({
    super.debugMessage = 'The requested auth provider is not supported',
    super.statusCode = 400,
    super.stackTrace,
  });

  @override
  UnsupportedProviderFailure withDebug(
    Object error, [
    StackTrace? stackTrace,
  ]) => UnsupportedProviderFailure(
    debugMessage: error.toString(),
    statusCode: statusCode,
    stackTrace: stackTrace,
  );
}

final class RefreshTokenFailure extends AuthFailure {
  const RefreshTokenFailure({
    super.debugMessage = 'Error refreshing token',
    super.statusCode = 401,
    super.stackTrace,
  });

  @override
  RefreshTokenFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      RefreshTokenFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}
