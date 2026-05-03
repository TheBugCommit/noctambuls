import 'package:google_sign_in/google_sign_in.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_provider_datasource.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart';

class GoogleAuthDataSourceImpl
    implements AuthProviderDataSource<GoogleAuthCredentials> {
  const GoogleAuthDataSourceImpl({
    required this.googleSignIn,
  });

  final GoogleSignIn googleSignIn;

  @override
  AuthProviderType get authProviderType => AuthProviderType.google;

  @override
  Future<String?> authenticate(GoogleAuthCredentials credentials) async {
    final account = await googleSignIn.signIn();

    if (account == null) return null;

    final auth = await account.authentication;
    return auth.idToken;
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
  }

  @override
  Future<String?> getPhotoUrl() async => googleSignIn.currentUser?.photoUrl;
}
