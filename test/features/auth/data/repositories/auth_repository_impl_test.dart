import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/auth/data/datasources/account_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_provider_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/models/auth_response_model.dart';
import 'package:noctambuls/features/auth/data/models/provider_auth_request_model.dart';
import 'package:noctambuls/features/auth/data/models/refresh_token_request_model.dart';
import 'package:noctambuls/features/auth/data/models/sign_up_request_model.dart';
import 'package:noctambuls/features/auth/data/network/token_refresh_manager.dart';
import 'package:noctambuls/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_up_usecase.dart';

import '../../helpers/jwt_helper.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAccountRemoteDataSource extends Mock
    implements AccountRemoteDataSource {}

class MockTokenLocalDataSource extends Mock implements TokenLocalDataSource {}

class MockTokenRefreshManager extends Mock implements TokenRefreshManager {}

class MockGoogleAuthProviderDataSource extends Mock
    implements AuthProviderDataSource<GoogleAuthCredentials> {}

class FakeGoogleAuthCredentials extends Fake implements GoogleAuthCredentials {}

class FakeProviderAuthRequestModel extends Fake
    implements ProviderAuthRequestModel {}

class FakeRefreshTokenRequestModel extends Fake
    implements RefreshTokenRequestModel {}

class FakeSignUpRequestModel extends Fake implements SignUpRequestModel {}

class MockLogger extends Mock implements IAppLogger {}

void main() {
  late MockAuthRemoteDataSource mockRemote;
  late MockAccountRemoteDataSource mockAccountRemote;
  late MockTokenLocalDataSource mockLocal;
  late MockGoogleAuthProviderDataSource mockGoogleProvider;
  late MockTokenRefreshManager mockTokenRefreshManager;
  late MockLogger mockLogger;

  const tUserId = 'user-123';
  const tUserEmail = 'test@noctambuls.cat';
  const tIdToken = 'google-id-token';
  const tRefreshToken = 'refresh-token-abc';

  late String tValidJwt;
  late String tExpiredJwt;
  late String tNewValidJwt;

  setUpAll(() {
    registerFallbackValue(FakeGoogleAuthCredentials());
    registerFallbackValue(FakeProviderAuthRequestModel());
    registerFallbackValue(FakeRefreshTokenRequestModel());
    registerFallbackValue(FakeSignUpRequestModel());
    registerFallbackValue(AuthProviderType.google);
  });

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    mockAccountRemote = MockAccountRemoteDataSource();
    mockLocal = MockTokenLocalDataSource();
    mockGoogleProvider = MockGoogleAuthProviderDataSource();
    mockTokenRefreshManager = MockTokenRefreshManager();
    mockLogger = MockLogger();

    when(
      () => mockGoogleProvider.authProviderType,
    ).thenReturn(AuthProviderType.google);
    when(
      () => mockGoogleProvider.getPhotoUrl(),
    ).thenAnswer((_) async => null);
    when(
      () => mockLocal.savePhotoUrl(any()),
    ).thenAnswer((_) async {});
    when(
      () => mockLocal.getPhotoUrl(),
    ).thenAnswer((_) async => null);
    when(
      () => mockLocal.saveUserId(any()),
    ).thenAnswer((_) async {});

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
        accountRemoteDataSource: mockAccountRemote,
        tokenLocalDataSource: mockLocal,
        refreshManager: mockTokenRefreshManager,
        providers: includeProvider
            ? {GoogleAuthCredentials: mockGoogleProvider}
            : {},
        logger: mockLogger,
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
        () => mockRemote.signInWithProvider(
          AuthProviderType.google,
          const ProviderAuthRequestModel(idToken: tIdToken),
        ),
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
      'hauria de retornar NetworkFailure si el DioException no té resposta',
      () async {
        when(
          () => mockGoogleProvider.authenticate(any()),
        ).thenAnswer((_) async => tIdToken);
        when(
          () => mockRemote.signInWithProvider(AuthProviderType.google, any()),
        ).thenThrow(
          DioException(requestOptions: RequestOptions(), response: null),
        );

        final result = await buildRepo().signIn(const GoogleAuthCredentials());

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) => expect(f, isA<NetworkFailure>()),
        );
      },
    );

    test(
      'hauria de retornar UserNotRegisteredFailure en DioException 404 del backend',
      () async {
        when(
          () => mockGoogleProvider.authenticate(any()),
        ).thenAnswer((_) async => tIdToken);
        when(
          () => mockRemote.signInWithProvider(AuthProviderType.google, any()),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 404,
              data: {
                'message': 'User not found',
                'code': 'NOT_FOUND',
                'details': {},
              },
            ),
          ),
        );

        final result = await buildRepo().signIn(const GoogleAuthCredentials());

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) {
            expect(f, isA<UserNotRegisteredFailure>());
            final unr = f as UserNotRegisteredFailure;
            expect(unr.idToken, tIdToken);
            expect(unr.providerType, AuthProviderType.google);
          },
        );
      },
    );

    test(
      'hauria de retornar SignInFailure amb el codi HTTP si DioException 4xx no és 404',
      () async {
        when(
          () => mockGoogleProvider.authenticate(any()),
        ).thenAnswer((_) async => tIdToken);
        when(
          () => mockRemote.signInWithProvider(AuthProviderType.google, any()),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 401,
              data: <String, dynamic>{},
            ),
          ),
        );

        final result = await buildRepo().signIn(const GoogleAuthCredentials());

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) {
            expect(f, isA<SignInFailure>());
            expect(f.statusCode, 401);
          },
        );
      },
    );
  });

  // ─── signUp ──────────────────────────────────────────────────────────────

  group('signUp', () {
    final tSignUpParams = SignUpParams(
      provider: AuthProviderType.google,
      idToken: tIdToken,
      name: 'Oriol',
      phone: '+34600000000',
    );

    test('hauria de retornar Ok(AuthUser) en el cas correcte', () async {
      when(
        () => mockRemote.signUpWithProvider(any(), any()),
      ).thenAnswer(
        (_) async => AuthResponseModel(
          accessToken: tValidJwt,
          refreshToken: tRefreshToken,
        ),
      );
      when(
        () => mockLocal.saveTokenPair(any(), any()),
      ).thenAnswer((_) async {});

      final result = await buildRepo().signUp(tSignUpParams);

      expect(result, isA<Ok<AuthUser>>());
      result.when(
        success: (user) {
          expect(user.id, tUserId);
          expect(user.email, tUserEmail);
        },
        failure: (_) => fail('esperava Ok(AuthUser)'),
      );
      verify(() => mockLocal.saveTokenPair(tValidJwt, tRefreshToken)).called(1);
      verify(() => mockLocal.saveUserId(tUserId)).called(1);
    });

    test(
      'hauria de retornar NetworkFailure si DioException no té resposta',
      () async {
        when(
          () => mockRemote.signUpWithProvider(any(), any()),
        ).thenThrow(
          DioException(requestOptions: RequestOptions(), response: null),
        );

        final result = await buildRepo().signUp(tSignUpParams);

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) => expect(f, isA<NetworkFailure>()),
        );
      },
    );

    test(
      'hauria de retornar ProviderTokenExpiredFailure si DioException 401',
      () async {
        when(
          () => mockRemote.signUpWithProvider(any(), any()),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 401,
            ),
          ),
        );

        final result = await buildRepo().signUp(tSignUpParams);

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) => expect(f, isA<ProviderTokenExpiredFailure>()),
        );
      },
    );

    test(
      'hauria de retornar BackendAuthFailure si DioException >= 500',
      () async {
        when(
          () => mockRemote.signUpWithProvider(any(), any()),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        final result = await buildRepo().signUp(tSignUpParams);

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) {
            expect(f, isA<BackendAuthFailure>());
            expect(f.statusCode, 500);
          },
        );
      },
    );

    test(
      'hauria de retornar SignUpFailure si DioException 4xx (no 401)',
      () async {
        when(
          () => mockRemote.signUpWithProvider(any(), any()),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 422,
            ),
          ),
        );

        final result = await buildRepo().signUp(tSignUpParams);

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) {
            expect(f, isA<SignUpFailure>());
            expect(f.statusCode, 422);
          },
        );
      },
    );

    test(
      'hauria de retornar BackendAuthFailure si llança excepció genèrica',
      () async {
        when(
          () => mockRemote.signUpWithProvider(any(), any()),
        ).thenThrow(Exception('unexpected error'));

        final result = await buildRepo().signUp(tSignUpParams);

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
      'hauria de retornar Err(InvalidTokenFailure) si no hi ha accés i no pot refrescar',
      () async {
        when(() => mockLocal.getAccessToken()).thenAnswer((_) async => null);
        when(
          () => mockTokenRefreshManager.refreshToken(),
        ).thenAnswer((_) async => null);

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava error'),
          failure: (f) => expect(f, isA<InvalidTokenFailure>()),
        );
        verify(() => mockTokenRefreshManager.refreshToken()).called(1);
      },
    );

    test(
      'hauria de retornar Ok(AuthUser) si el token existeix i no ha expirat',
      () async {
        // Assumint que hem posat el "return Ok(expiredUser);" d'hora si no està caducat
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => tValidJwt);

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser>>());
        result.when(
          success: (user) {
            expect(user.id, tUserId);
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
        // Simulem que el manager retorna amb èxit un nou token
        when(
          () => mockTokenRefreshManager.refreshToken(),
        ).thenAnswer((_) async => tNewValidJwt);

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser>>());
        result.when(
          success: (user) {
            expect(user.email, 'new@noctambuls.cat');
          },
          failure: (_) => fail('esperava Ok(AuthUser) refrescat'),
        );
        verify(() => mockTokenRefreshManager.refreshToken()).called(1);
      },
    );

    test(
      'hauria de retornar Ok(expiredUser) en mode offline si hi ha user expirat',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => tExpiredJwt);
        // Simulem un error de xarxa en el procés de refresc (sense resposta = sense connexió)
        when(() => mockTokenRefreshManager.refreshToken()).thenThrow(
          DioException(requestOptions: RequestOptions(), response: null),
        );

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Ok<AuthUser>>());
        result.when(
          success: (user) {
            expect(
              user.id,
              tUserId,
            ); // Validem que retorna l'usuari caducat per fer offline-first
          },
          failure: (_) => fail('esperava Ok(expiredUser) en mode offline'),
        );
      },
    );

    test(
      'hauria de retornar Err(NetworkFailure) en mode offline si no hi ha user previ',
      () async {
        when(() => mockLocal.getAccessToken()).thenAnswer((_) async => null);
        when(() => mockTokenRefreshManager.refreshToken()).thenThrow(
          DioException(requestOptions: RequestOptions(), response: null),
        );

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava Err(NetworkFailure)'),
          failure: (f) => expect(f, isA<NetworkFailure>()),
        );
      },
    );

    test(
      'hauria de retornar Err(InvalidTokenFailure) si el JWT és malformat i no es pot refrescar',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => 'not-a-valid-jwt');
        when(
          () => mockTokenRefreshManager.refreshToken(),
        ).thenAnswer((_) async => null);

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava Err(InvalidTokenFailure)'),
          failure: (f) => expect(f, isA<InvalidTokenFailure>()),
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

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava Err(TokenStorageFailure)'),
          failure: (f) => expect(f, isA<TokenStorageFailure>()),
        );
      },
    );

    test(
      'hauria de retornar Err(RefreshTokenFailure) si el refresh retorna DioException no de xarxa',
      () async {
        when(
          () => mockLocal.getAccessToken(),
        ).thenAnswer((_) async => tExpiredJwt);
        when(() => mockTokenRefreshManager.refreshToken()).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 401,
              data: <String, dynamic>{},
            ),
          ),
        );

        final result = await buildRepo().getStoredAuth();

        expect(result, isA<Err<AuthUser>>());
        result.when(
          success: (_) => fail('esperava Err(RefreshTokenFailure)'),
          failure: (f) => expect(f, isA<RefreshTokenFailure>()),
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
        () => mockRemote.invalidateToken(
          const RefreshTokenRequestModel(refreshToken: tRefreshToken),
        ),
      ).thenAnswer((_) async {});
      when(() => mockLocal.deleteAllTokens()).thenAnswer((_) async {});
      when(() => mockGoogleProvider.signOut()).thenAnswer((_) async {});

      final result = await buildRepo().signOut();

      expect(result, isA<Ok<Unit>>());
      verify(
        () => mockRemote.invalidateToken(
          const RefreshTokenRequestModel(refreshToken: tRefreshToken),
        ),
      ).called(1);
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

    test(
      'hauria de retornar Err(TokenStorageFailure) si deleteAllTokens llança excepció',
      () async {
        when(
          () => mockLocal.getRefreshToken(),
        ).thenAnswer((_) async => null);
        when(
          () => mockLocal.deleteAllTokens(),
        ).thenThrow(Exception('storage error'));

        final result = await buildRepo().signOut();

        expect(result, isA<Err<Unit>>());
        result.when(
          success: (_) => fail('esperava Err(TokenStorageFailure)'),
          failure: (f) => expect(f, isA<TokenStorageFailure>()),
        );
      },
    );
  });

  // ─── deleteAccount ───────────────────────────────────────────────────────

  group('deleteAccount', () {
    test('hauria de retornar Ok(Unit) en el cas correcte', () async {
      when(
        () => mockAccountRemote.deleteAccount(),
      ).thenAnswer((_) async {});
      when(() => mockLocal.deleteAllTokens()).thenAnswer((_) async {});
      when(() => mockGoogleProvider.signOut()).thenAnswer((_) async {});

      final result = await buildRepo().deleteAccount();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockAccountRemote.deleteAccount()).called(1);
      verify(() => mockLocal.deleteAllTokens()).called(1);
      verify(() => mockGoogleProvider.signOut()).called(1);
    });

    test(
      'hauria de retornar DeleteAccountFailure amb el codi HTTP si DioException',
      () async {
        when(
          () => mockAccountRemote.deleteAccount(),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 403,
            ),
          ),
        );

        final result = await buildRepo().deleteAccount();

        expect(result, isA<Err<Unit>>());
        result.when(
          success: (_) => fail('esperava Err(DeleteAccountFailure)'),
          failure: (f) {
            expect(f, isA<DeleteAccountFailure>());
            expect(f.statusCode, 403);
          },
        );
      },
    );

    test(
      'hauria de retornar DeleteAccountFailure amb codi 400 si DioException sense resposta',
      () async {
        when(
          () => mockAccountRemote.deleteAccount(),
        ).thenThrow(
          DioException(requestOptions: RequestOptions(), response: null),
        );

        final result = await buildRepo().deleteAccount();

        expect(result, isA<Err<Unit>>());
        result.when(
          success: (_) => fail('esperava Err(DeleteAccountFailure)'),
          failure: (f) {
            expect(f, isA<DeleteAccountFailure>());
            expect(f.statusCode, 400);
          },
        );
      },
    );

    test(
      'hauria de retornar DeleteAccountFailure si llança excepció genèrica',
      () async {
        when(
          () => mockAccountRemote.deleteAccount(),
        ).thenThrow(Exception('unexpected'));

        final result = await buildRepo().deleteAccount();

        expect(result, isA<Err<Unit>>());
        result.when(
          success: (_) => fail('esperava Err(DeleteAccountFailure)'),
          failure: (f) => expect(f, isA<DeleteAccountFailure>()),
        );
      },
    );
  });
}
