import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_credentials.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/usecases/get_stored_auth_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.getStoredAuthUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
  }) : super(const AuthInitial()) {
    on<CheckStoredAuth>(_onCheckStoredAuth);
    on<SignInWithGoogleRequested>(
      (event, emit) => _handleSignIn(const GoogleAuthCredentials(), emit),
    );
    on<SignOutRequested>(_onSignOut);
  }

  final GetStoredAuthUseCase getStoredAuthUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;

  Future<void> _onCheckStoredAuth(
    CheckStoredAuth event,
    Emitter<AuthState> emit,
  ) async {
    final result = await getStoredAuthUseCase();
    result.when(
      success: (user) {
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(const Unauthenticated());
        }
      },
      failure: (failure) {
        // Expired/invalid token is a silent failure — just show login
        if (failure is! InvalidTokenFailure) {
          AppLogger.failure(failure);
        }
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
    result.when(
      success: (user) => emit(Authenticated(user: user)),
      failure: (failure) {
        if (failure is SignInCancelledFailure) {
          emit(const Unauthenticated());
        } else {
          AppLogger.failure(failure);
          emit(AuthError(failure: failure));
        }
      },
    );
  }

  Future<void> _onSignOut(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await signOutUseCase();
    result.when(
      success: (_) => emit(const Unauthenticated()),
      failure: (failure) {
        AppLogger.failure(failure);
        emit(const Unauthenticated());
      },
    );
  }
}
