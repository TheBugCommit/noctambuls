import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart';

class SignInUseCase {
  SignInUseCase(this.repository);

  final AuthRepository repository;

  Future<Result<AuthUser>> call(AuthCredentials credentials) =>
      repository.signIn(credentials);
}
