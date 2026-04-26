import 'package:noctambuls/features/auth/domain/entities/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';

abstract class AuthProviderDataSource<T extends AuthCredentials> {
  AuthProviderType get authProviderType;

  Future<String?> authenticate(T credentials);

  Future<void> signOut();
}
