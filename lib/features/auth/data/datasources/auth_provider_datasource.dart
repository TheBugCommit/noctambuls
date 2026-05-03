import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart';

abstract class AuthProviderDataSource<T extends AuthCredentials> {
  AuthProviderType get authProviderType;

  Future<String?> authenticate(T credentials);

  Future<void> signOut();

  Future<String?> getPhotoUrl();
}
