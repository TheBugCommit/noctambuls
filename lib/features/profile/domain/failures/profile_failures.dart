import 'package:noctambuls/core/domain/error/failure.dart';

sealed class ProfileFailure extends Failure {
  const ProfileFailure({
    required super.debugMessage,
    required super.statusCode,
    super.stackTrace,
  });
}

final class ProfileNetworkFailure extends ProfileFailure {
  const ProfileNetworkFailure({
    super.debugMessage = 'Network error fetching profile',
    super.statusCode = 0,
    super.stackTrace,
  });

  @override
  ProfileNetworkFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      ProfileNetworkFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class ProfileNotFoundFailure extends ProfileFailure {
  const ProfileNotFoundFailure({
    super.debugMessage = 'Profile not found',
    super.statusCode = 404,
    super.stackTrace,
  });

  @override
  ProfileNotFoundFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      ProfileNotFoundFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}

final class ProfileUpdateFailure extends ProfileFailure {
  const ProfileUpdateFailure({
    super.debugMessage = 'Failed to update profile',
    super.statusCode = 400,
    super.stackTrace,
  });

  @override
  ProfileUpdateFailure withDebug(Object error, [StackTrace? stackTrace]) =>
      ProfileUpdateFailure(
        debugMessage: error.toString(),
        statusCode: statusCode,
        stackTrace: stackTrace,
      );
}
