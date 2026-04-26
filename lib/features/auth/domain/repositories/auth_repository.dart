import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<Result<AuthUser>> signIn(AuthCredentials credentials);

  Future<Result<Unit>> signOut();

  /// Returns [Ok(null)] when no token is stored.
  /// Returns [Ok(AuthUser)] when a valid token exists.
  /// Returns [Err] when the stored token is expired or malformed.
  Future<Result<AuthUser?>> getStoredAuth();
}
