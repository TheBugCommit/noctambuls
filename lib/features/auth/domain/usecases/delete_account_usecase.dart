import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccountUseCase {
  const DeleteAccountUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<Unit>> call() => _repository.deleteAccount();
}
