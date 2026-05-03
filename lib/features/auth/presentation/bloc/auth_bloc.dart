import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/get_stored_auth_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.getStoredAuthUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.signUpUseCase,
    required this.deleteAccountUseCase,
    required this.dbManager,
    required this.logger,
  }) : super(const AuthInitial()) {
    on<CheckStoredAuth>(_onCheckStoredAuth);
    on<SignInWithGoogleRequested>(
      (event, emit) => _handleSignIn(const GoogleAuthCredentials(), emit),
    );
    on<SignOutRequested>(_onSignOut);
    on<SignUpRequested>(_onSignUpRequested);
    on<DeleteAccountRequested>(_onDeleteAccount);
  }

  final GetStoredAuthUseCase getStoredAuthUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final SignUpUseCase signUpUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final UserDatabaseManager dbManager;
  final IAppLogger logger;

  Future<void> _onCheckStoredAuth(
    CheckStoredAuth event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await getStoredAuthUseCase();
    await result.when(
      success: (user) async {
        await dbManager.initDatabase(user.id);
        emit(Authenticated(user: user));
      },
      failure: (failure) {
        logger.failure(failure);
        emit(const Unauthenticated());
      },
    );
  }

  Future<void> _handleSignIn(
    AuthCredentials credentials,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await signInUseCase(credentials);
    await result.when(
      success: (user) async {
        await dbManager.initDatabase(user.id);
        emit(Authenticated(user: user));
      },
      failure: (failure) {
        if (failure is SignInCancelledFailure) {
          emit(const Unauthenticated());
        } else if (failure is UserNotRegisteredFailure) {
          emit(
            AuthRequiresProfile(
              idToken: failure.idToken,
              providerType: failure.providerType,
            ),
          );
        } else {
          logger.failure(failure);
          emit(AuthError(failure: failure));
        }
      },
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthRequiresProfile) return;
    final currentState = state as AuthRequiresProfile;
    emit(const AuthLoading());

    final params = SignUpParams(
      provider: currentState.providerType,
      idToken: currentState.idToken,
      name: event.name,
      phone: event.phone,
    );

    final result = await signUpUseCase(params);

    await result.when(
      success: (user) async {
        await dbManager.initDatabase(user.id);
        emit(Authenticated(user: user));
      },
      failure: (failure) {
        logger.failure(failure);
        emit(AuthError(failure: failure));
        if (failure.statusCode == 401) {
          emit(const Unauthenticated());
        }
      },
    );
  }

  Future<void> _onSignOut(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await signOutUseCase();
    await result.when(
      success: (_) async {
        await dbManager.closeDatabase();
        emit(const Unauthenticated());
      },
      failure: (failure) {
        logger.failure(failure);
        emit(const Unauthenticated());
      },
    );
  }

  Future<void> _onDeleteAccount(
    DeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is! Authenticated) return;
    final userId = currentState.user.id;

    emit(const AuthLoading());
    final result = await deleteAccountUseCase();
    await result.when(
      success: (_) async {
        await dbManager.deleteDatabase(userId);
        emit(const Unauthenticated());
      },
      failure: (failure) {
        logger.failure(failure);
        emit(AuthError(failure: failure));
      },
    );
  }
}
