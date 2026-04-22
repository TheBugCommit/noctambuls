import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  SignOutUseCase(this.repository);

  final AuthRepository repository;

  Future<Result<Unit>> call() => repository.signOut();
}
