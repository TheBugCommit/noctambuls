import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_provider_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/models/auth_response_model.dart';
import 'package:noctambuls/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';

import '../../helpers/jwt_helper.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockTokenLocalDataSource extends Mock implements TokenLocalDataSource {}

class MockGoogleAuthProviderDataSource extends Mock
    implements AuthProviderDataSource<GoogleAuthCredentials> {}

class FakeGoogleAuthCredentials extends Fake implements GoogleAuthCredentials {}

void main() {
  late MockAuthRemoteDataSource mockRemote;
  late MockTokenLocalDataSource mockLocal;
  late MockGoogleAuthProviderDataSource mockGoogleProvider;

  const tUserId = 'user-123';
  const tUserEmail = 'test@noctambuls.cat';
  const tIdToken = 'google-id-token';
  const tRefreshToken = 'refresh-token-abc';

  late String tValidJwt;
  late String tExpiredJwt;
  late String tNewValidJwt;

  setUpAll(() {
    registerFallbackValue(FakeGoogleAuthCredentials());
  });

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    mockLocal = MockTokenLocalDataSource();
    mockGoogleProvider = MockGoogleAuthProviderDataSource();

    tValidJwt = makeJwt(id: tUserId, email: tUserEmail, exp: futureExp);
    tExpiredJwt = makeJwt(id: tUserId, email: tUserEmail, exp: pastExp);
    tNewValidJwt = makeJwt(
      id: 'user-456',
      email: 'new@noctambuls.cat',
      exp: futureExp,
    );
  });

  AuthRepositoryImpl buildRepo({bool includeProvider = true}) =>
      AuthRepositoryImpl(
        remoteDataSource: mockRemote,
        tokenLocalDataSource: mockLocal,
        providers: includeProvider
            ? {GoogleAuthCredentials: mockGoogleProvider}
            : {},
      );

  group('signIn', () {
    test(
      'hauria de retornar UnsupportedProviderFailure si el provider no és registrat',
      () async {
        final repo = buildRepo(includeProvider: false);

        final result = await repo.signIn(const GoogleAuthCredentials());

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) => expect(f, isA<UnsupportedProviderFailure>()),
        );
      },
    );

    test(
      'hauria de retornar SignInCancelledFailure si el provider retorna null',
      () async {
        when(
          () => mockGoogleProvider.authenticate(any()),
        ).thenAnswer((_) async => null);

        final result = await buildRepo().signIn(const GoogleAuthCredentials());

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) => expect(f, isA<SignInCancelledFailure>()),
        );
      },
    );

    test('hauria de retornar Ok(AuthUser) en el cas correcte', () async {
      when(
        () => mockGoogleProvider.authenticate(any()),
      ).thenAnswer((_) async => tIdToken);
      when(
        () => mockRemote.signInWithProvider(AuthProviderType.google, tIdToken),
      ).thenAnswer(
        (_) async => AuthResponseModel(
          accessToken: tValidJwt,
          refreshToken: tRefreshToken,
        ),
      );
      when(
        () => mockLocal.saveTokenPair(any(), any()),
      ).thenAnswer((_) async {});

      final result = await buildRepo().signIn(const GoogleAuthCredentials());

      expect(result, isA<Ok<AuthUser>>());
      result.when(
        success: (user) {
          expect(user.id, tUserId);
          expect(user.email, tUserEmail);
        },
        failure: (_) => fail('esperava èxit'),
      );
      verify(() => mockLocal.saveTokenPair(tValidJwt, tRefreshToken)).called(1);
    });

    test(
      'hauria de retornar BackendAuthFailure si el remote llença excepció',
      () async {
        when(
          () => mockGoogleProvider.authenticate(any()),
        ).thenAnswer((_) async => tIdToken);
        when(
          () => mockRemote.signInWithProvider(AuthProviderType.google, any()),
        ).thenThrow(Exception('network error'));

        final result = await buildRepo().signIn(const GoogleAuthCredentials());

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) => expect(f, isA<BackendAuthFailure>()),
        );
      },
    );

    test(
      'hauria de retornar BackendAuthFailure si saveTokenPair llença excepció',
      () async {
        when(
          () => mockGoogleProvider.authenticate(any()),
        ).thenAnswer((_) async => tIdToken);
        when(
          () => mockRemote.signInWithProvider(AuthProviderType.google, any()),
        ).thenAnswer(
          (_) async => AuthResponseModel(
            accessToken: tValidJwt,
            refreshToken: tRefreshToken,
          ),
        );
        when(
          () => mockLocal.saveTokenPair(any(), any()),
        ).thenThrow(Exception('storage error'));

        final result = await buildRepo().signIn(const GoogleAuthCredentials());

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) => expect(f, isA<BackendAuthFailure>()),
        );
      },
    );
  });

  group('getStoredAuth', () {
    test(
      'hauria de retornar Ok(null) si no hi ha access token ni refresh token',
      () async {
        when(() => mockLocal.getAccessToken()).thenAnswer((_) async => null);
        when(() => mockLocal.getRefreshToken()).thenAnswer((_) async => null);

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser?>>());
        result.when(
          success: (user) => expect(user, isNull),
          failure: (_) => fail('esperava Ok(null)'),
        );
      },
    );

    test(
      'hauria de retornar Ok(AuthUser) si el token és vàlid i no ha expirat',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => tValidJwt);

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser?>>());
        result.when(
          success: (user) {
            expect(user, isNotNull);
            expect(user!.id, tUserId);
            expect(user.email, tUserEmail);
          },
          failure: (_) => fail('esperava Ok(AuthUser)'),
        );
      },
    );

    test(
      'hauria de fer refresh i retornar el nou AuthUser si el token ha expirat',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => tExpiredJwt);
        when(
          () => mockLocal.getRefreshToken(),
        ).thenAnswer((_) async => tRefreshToken);
        when(() => mockRemote.refreshTokens(tRefreshToken)).thenAnswer(
          (_) async => AuthResponseModel(
            accessToken: tNewValidJwt,
            refreshToken: 'new-refresh-token',
          ),
        );
        when(
          () => mockLocal.saveTokenPair(any(), any()),
        ).thenAnswer((_) async {});

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser?>>());
        result.when(
          success: (user) {
            expect(user, isNotNull);
            expect(user!.email, 'new@noctambuls.cat');
          },
          failure: (_) => fail('esperava Ok(AuthUser) refrescat'),
        );
        verify(() => mockRemote.refreshTokens(tRefreshToken)).called(1);
      },
    );

    test(
      'hauria de retornar Ok(null) si el token ha expirat i no hi ha refresh token',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => tExpiredJwt);
        when(() => mockLocal.getRefreshToken()).thenAnswer((_) async => null);

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser?>>());
        result.when(
          success: (user) => expect(user, isNull),
          failure: (_) => fail('esperava Ok(null)'),
        );
      },
    );

    test(
      'hauria de retornar Ok(expiredUser) en mode offline si hi ha user expirat',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => tExpiredJwt);
        when(
          () => mockLocal.getRefreshToken(),
        ).thenAnswer((_) async => tRefreshToken);
        when(() => mockRemote.refreshTokens(any())).thenThrow(
          DioException(requestOptions: RequestOptions(), response: null),
        );

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser?>>());
        result.when(
          success: (user) {
            expect(user, isNotNull);
            expect(user!.id, tUserId);
          },
          failure: (_) => fail('esperava Ok(expiredUser) en mode offline'),
        );
      },
    );

    test(
      'hauria de retornar Ok(null) en mode offline si no hi ha user previ',
      () async {
        when(() => mockLocal.getAccessToken()).thenAnswer((_) async => null);
        when(
          () => mockLocal.getRefreshToken(),
        ).thenAnswer((_) async => tRefreshToken);
        when(() => mockRemote.refreshTokens(any())).thenThrow(
          DioException(requestOptions: RequestOptions(), response: null),
        );

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser?>>());
        result.when(
          success: (user) => expect(user, isNull),
          failure: (_) => fail('esperava Ok(null) en mode offline sense user'),
        );
      },
    );

    test(
      'hauria de retornar Err(InvalidTokenFailure) si el servidor rebutja el refresh',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => tExpiredJwt);
        when(
          () => mockLocal.getRefreshToken(),
        ).thenAnswer((_) async => tRefreshToken);
        when(() => mockRemote.refreshTokens(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 401,
            ),
          ),
        );
        when(() => mockLocal.deleteAllTokens()).thenAnswer((_) async {});

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Err<AuthUser?>>());
        result.when(
          success: (_) => fail('esperava Err(InvalidTokenFailure)'),
          failure: (f) => expect(f, isA<InvalidTokenFailure>()),
        );
        verify(() => mockLocal.deleteAllTokens()).called(1);
      },
    );

    test(
      'hauria de retornar Ok(null) si el JWT és malformat i no hi ha refresh',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => 'not-a-valid-jwt');
        when(() => mockLocal.getRefreshToken()).thenAnswer((_) async => null);

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser?>>());
        result.when(
          success: (user) => expect(user, isNull),
          failure: (_) => fail('esperava Ok(null) amb JWT malformat'),
        );
      },
    );

    test(
      'hauria de retornar Err(TokenStorageFailure) si el storage llença excepció',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenThrow(Exception('storage error'));

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Err<AuthUser?>>());
        result.when(
          success: (_) => fail('esperava Err(TokenStorageFailure)'),
          failure: (f) => expect(f, isA<TokenStorageFailure>()),
        );
      },
    );
  });

  group('signOut', () {
    test('hauria de retornar Ok(Unit) en el cas correcte', () async {
      when(
        () => mockLocal.getRefreshToken(),
      ).thenAnswer((_) async => tRefreshToken);
      when(
        () => mockRemote.invalidateToken(tRefreshToken),
      ).thenAnswer((_) async {});
      when(() => mockLocal.deleteAllTokens()).thenAnswer((_) async {});
      when(() => mockGoogleProvider.signOut()).thenAnswer((_) async {});

      final result = await buildRepo().signOut();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockRemote.invalidateToken(tRefreshToken)).called(1);
      verify(() => mockLocal.deleteAllTokens()).called(1);
    });

    test(
      'hauria de retornar Ok(Unit) i no cridar invalidateToken si no hi ha refresh token',
      () async {
        when(() => mockLocal.getRefreshToken()).thenAnswer((_) async => null);
        when(() => mockLocal.deleteAllTokens()).thenAnswer((_) async {});
        when(() => mockGoogleProvider.signOut()).thenAnswer((_) async {});

        final result = await buildRepo().signOut();

        expect(result, isA<Ok<Unit>>());
        verifyNever(() => mockRemote.invalidateToken(any()));
        verify(() => mockLocal.deleteAllTokens()).called(1);
      },
    );

    test(
      'hauria de retornar Ok(Unit) si invalidateToken falla (error de xarxa silenciós)',
      () async {
        when(
          () => mockLocal.getRefreshToken(),
        ).thenAnswer((_) async => tRefreshToken);
        when(
          () => mockRemote.invalidateToken(any()),
        ).thenThrow(Exception('network error'));
        when(() => mockLocal.deleteAllTokens()).thenAnswer((_) async {});
        when(() => mockGoogleProvider.signOut()).thenAnswer((_) async {});

        final result = await buildRepo().signOut();

        expect(result, isA<Ok<Unit>>());
        verify(() => mockLocal.deleteAllTokens()).called(1);
      },
    );
  });
}
