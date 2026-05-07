import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';

class AuthRouterGuard {
  static String? redirect(GoRouterState state, AuthState authState) {
    final isOnSignIn = state.matchedLocation == AppRoutes.signin;
    final isOnSignUp = state.matchedLocation == AppRoutes.signup;
    final isOnSplash = state.matchedLocation == AppRoutes.splash;

    if (authState is AuthInitial) {
      return isOnSplash ? null : AppRoutes.splash;
    }

    if (authState is AuthLoading || authState is AuthError) {
      return null;
    }

    if (authState is Unauthenticated) {
      if (isOnSignIn) return null;
      return AppRoutes.signin;
    }

    if (authState is AuthRequiresProfile) {
      if (isOnSignUp) return null;
      return AppRoutes.signup;
    }

    if (authState is Authenticated) {
      if (isOnSignIn || isOnSignUp || isOnSplash) return AppRoutes.home;
    }

    return null;
  }
}
