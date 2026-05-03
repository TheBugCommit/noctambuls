import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.provider,
    required this.idToken,
    required this.name,
    required this.phone,
  });

  final AuthProviderType provider;
  final String idToken;
  final String name;
  final String phone;

  @override
  List<Object?> get props => [provider, idToken, name, phone];
}

class SignUpUseCase {
  SignUpUseCase(this.repository);

  final AuthRepository repository;

  Future<Result<AuthUser>> call(SignUpParams params) =>
      repository.signUp(params);
}
