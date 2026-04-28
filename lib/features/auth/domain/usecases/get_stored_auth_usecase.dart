import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';

class GetStoredAuthUseCase {
  GetStoredAuthUseCase(this.repository);

  final AuthRepository repository;

  Future<Result<AuthUser>> call() => repository.getStoredAuth();
}
