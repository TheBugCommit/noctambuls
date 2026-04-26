import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  SignInUseCase(this.repository);

  final AuthRepository repository;

  Future<Result<AuthUser>> call(AuthCredentials credentials) =>
      repository.signIn(credentials);
}
