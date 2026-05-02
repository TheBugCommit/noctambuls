import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_up_usecase.dart';

abstract class AuthRepository {
  Future<Result<AuthUser>> signIn(AuthCredentials credentials);

  Future<Result<AuthUser>> signUp(SignUpParams params);

  Future<Result<Unit>> signOut();

  Future<Result<AuthUser>> getStoredAuth();
}
