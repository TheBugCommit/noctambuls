import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_up_usecase.dart'
    show SignUpParams;
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart'
    show GoogleAuthCredentials;
import 'package:noctambuls/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/get_stored_auth_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';

class MockGetStoredAuthUseCase extends Mock implements GetStoredAuthUseCase {}

class MockSignInUseCase extends Mock implements SignInUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockDeleteAccountUseCase extends Mock implements DeleteAccountUseCase {}

class MockUserDatabaseManager extends Mock implements UserDatabaseManager {}

class MockLogger extends Mock implements IAppLogger {}

void main() {
  late MockGetStoredAuthUseCase mockGetStoredAuth;
  late MockSignInUseCase mockSignIn;
  late MockSignOutUseCase mockSignOut;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockDeleteAccountUseCase mockDeleteAccount;
  late MockUserDatabaseManager mockDbManager;
  late MockLogger mockLogger;

  final tAuthUser = AuthUser(
    id: 'user-123',
    email: 'test@noctambuls.cat',
    tokenExpiry: DateTime(2099),
  );

  setUpAll(() {
    registerFallbackValue(const GoogleAuthCredentials());
    registerFallbackValue(
      const SignUpParams(
        provider: AuthProviderType.google,
        idToken: 'fallback-token',
        name: 'Fallback',
        phone: '+34600000000',
      ),
    );
  });

  setUp(() {
    mockGetStoredAuth = MockGetStoredAuthUseCase();
    mockSignIn = MockSignInUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    mockSignOut = MockSignOutUseCase();
    mockDeleteAccount = MockDeleteAccountUseCase();
    mockDbManager = MockUserDatabaseManager();
    mockLogger = MockLogger();

    when(() => mockDbManager.initDatabase(any())).thenAnswer((_) async {});
    when(() => mockDbManager.closeDatabase()).thenAnswer((_) async {});
    when(() => mockDbManager.deleteDatabase(any())).thenAnswer((_) async {});
  });

  AuthBloc buildBloc() => AuthBloc(
    getStoredAuthUseCase: mockGetStoredAuth,
    signInUseCase: mockSignIn,
    signUpUseCase: mockSignUpUseCase,
    signOutUseCase: mockSignOut,
    deleteAccountUseCase: mockDeleteAccount,
    dbManager: mockDbManager,
    logger: mockLogger,
  );

  test("l'estat inicial hauria de ser AuthInitial", () {
    expect(buildBloc().state, const AuthInitial());
  });

  group('CheckStoredAuth', () {
    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre Unauthenticated si no hi ha sessió guardada",
      build: () {
        when(
          () => mockGetStoredAuth(),
        ).thenAnswer((_) async => const Err(UnknownFailure()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CheckStoredAuth()),
      expect: () => [const AuthLoading(), const Unauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre Authenticated si hi ha un usuari guardat",
      build: () {
        when(() => mockGetStoredAuth()).thenAnswer((_) async => Ok(tAuthUser));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CheckStoredAuth()),
      expect: () => [const AuthLoading(), Authenticated(user: tAuthUser)],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre Unauthenticated de forma silenciosa si el token és invàlid",
      build: () {
        when(() => mockGetStoredAuth()).thenAnswer(
          (_) async => const Err(InvalidTokenFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CheckStoredAuth()),
      expect: () => [const AuthLoading(), const Unauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre Unauthenticated si el storage falla",
      build: () {
        when(() => mockGetStoredAuth()).thenAnswer(
          (_) async => const Err(TokenStorageFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CheckStoredAuth()),
      expect: () => [const AuthLoading(), const Unauthenticated()],
    );
  });

  group('SignInWithGoogleRequested', () {
    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre AuthLoading i Authenticated si el sign-in és correcte",
      build: () {
        when(() => mockSignIn(any())).thenAnswer((_) async => Ok(tAuthUser));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SignInWithGoogleRequested()),
      expect: () => [
        const AuthLoading(),
        Authenticated(user: tAuthUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre AuthLoading i Unauthenticated si l'usuari cancel·la",
      build: () {
        when(() => mockSignIn(any())).thenAnswer(
          (_) async => const Err(SignInCancelledFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SignInWithGoogleRequested()),
      expect: () => [
        const AuthLoading(),
        const Unauthenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre AuthLoading i AuthError si el backend falla",
      build: () {
        when(() => mockSignIn(any())).thenAnswer(
          (_) async => const Err(BackendAuthFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SignInWithGoogleRequested()),
      expect: () => [
        const AuthLoading(),
        const AuthError(failure: BackendAuthFailure()),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre AuthLoading i AuthError si hi ha error de xarxa",
      build: () {
        when(() => mockSignIn(any())).thenAnswer(
          (_) async => const Err(NetworkFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SignInWithGoogleRequested()),
      expect: () => [
        const AuthLoading(),
        const AuthError(failure: NetworkFailure()),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre AuthRequiresProfile si l'usuari no està registrat",
      build: () {
        when(() => mockSignIn(any())).thenAnswer(
          (_) async => const Err(
            UserNotRegisteredFailure(
              idToken: 'id-token-abc',
              providerType: AuthProviderType.google,
            ),
          ),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SignInWithGoogleRequested()),
      expect: () => [
        const AuthLoading(),
        const AuthRequiresProfile(
          idToken: 'id-token-abc',
          providerType: AuthProviderType.google,
        ),
      ],
    );
  });

  // ─── SignUpRequested ──────────────────────────────────────────────────────

  group('SignUpRequested', () {
    blocTest<AuthBloc, AuthState>(
      "hauria d'ignorar si l'estat no és AuthRequiresProfile",
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const SignUpRequested(name: 'Oriol', phone: '+34600000000')),
      expect: () => <AuthState>[],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre Authenticated si el sign-up és correcte",
      build: () {
        when(
          () => mockSignUpUseCase(any()),
        ).thenAnswer((_) async => Ok(tAuthUser));
        return buildBloc();
      },
      seed: () => const AuthRequiresProfile(
        idToken: 'id-token-abc',
        providerType: AuthProviderType.google,
      ),
      act: (bloc) =>
          bloc.add(const SignUpRequested(name: 'Oriol', phone: '+34600000000')),
      expect: () => [const AuthLoading(), Authenticated(user: tAuthUser)],
      verify: (_) =>
          verify(() => mockDbManager.initDatabase(tAuthUser.id)).called(1),
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre AuthError si el sign-up falla",
      build: () {
        when(
          () => mockSignUpUseCase(any()),
        ).thenAnswer((_) async => const Err(SignUpFailure()));
        return buildBloc();
      },
      seed: () => const AuthRequiresProfile(
        idToken: 'id-token-abc',
        providerType: AuthProviderType.google,
      ),
      act: (bloc) =>
          bloc.add(const SignUpRequested(name: 'Oriol', phone: '+34600000000')),
      expect: () => [
        const AuthLoading(),
        const AuthError(failure: SignUpFailure()),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre AuthError i Unauthenticated si falla amb ProviderTokenExpiredFailure (401)",
      build: () {
        when(
          () => mockSignUpUseCase(any()),
        ).thenAnswer(
          (_) async => const Err(ProviderTokenExpiredFailure()),
        );
        return buildBloc();
      },
      seed: () => const AuthRequiresProfile(
        idToken: 'id-token-abc',
        providerType: AuthProviderType.google,
      ),
      act: (bloc) =>
          bloc.add(const SignUpRequested(name: 'Oriol', phone: '+34600000000')),
      expect: () => [
        const AuthLoading(),
        const AuthError(failure: ProviderTokenExpiredFailure()),
        const Unauthenticated(),
      ],
    );
  });

  // ─── DeleteAccountRequested ───────────────────────────────────────────────

  group('DeleteAccountRequested', () {
    blocTest<AuthBloc, AuthState>(
      "hauria d'ignorar si l'estat no és Authenticated",
      build: buildBloc,
      act: (bloc) => bloc.add(const DeleteAccountRequested()),
      expect: () => <AuthState>[],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre Unauthenticated si l'eliminació és correcta",
      build: () {
        when(
          () => mockDeleteAccount(),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      seed: () => Authenticated(user: tAuthUser),
      act: (bloc) => bloc.add(const DeleteAccountRequested()),
      expect: () => [const AuthLoading(), const Unauthenticated()],
      verify: (_) => verify(
        () => mockDbManager.deleteDatabase(tAuthUser.id),
      ).called(1),
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre AuthError i restaurar l'estat Authenticated si falla",
      build: () {
        when(
          () => mockDeleteAccount(),
        ).thenAnswer((_) async => const Err(DeleteAccountFailure()));
        return buildBloc();
      },
      seed: () => Authenticated(user: tAuthUser),
      act: (bloc) => bloc.add(const DeleteAccountRequested()),
      expect: () => [
        const AuthLoading(),
        const AuthError(failure: DeleteAccountFailure()),
        Authenticated(user: tAuthUser),
      ],
    );
  });

  group('SignOutRequested', () {
    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre Unauthenticated quan el sign-out és correcte",
      build: () {
        when(
          () => mockSignOut(),
        ).thenAnswer((_) async => const Ok(Unit.instance));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => [const AuthLoading(), const Unauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      "hauria d'emetre Unauthenticated fins i tot si el sign-out falla",
      build: () {
        when(() => mockSignOut()).thenAnswer(
          (_) async => const Err(TokenStorageFailure()),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => [const AuthLoading(), const Unauthenticated()],
    );
  });
}
