import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/navigation/go_router_refresh_stream.dart';
import 'package:noctambuls/core/navigation/main_navigation_screen.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/auth/presentation/pages/login/login_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/home_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/observing_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/review_page.dart';
import 'package:noctambuls/features/settings/presentation/pages/settings_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter makeRouter(AuthBloc authBloc) => GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  refreshListenable: GoRouterRefreshStream(authBloc.stream),
  redirect: (context, state) {
    final authState = authBloc.state;
    final isOnLogin = state.matchedLocation == AppRoutes.login;

    if (authState is AuthInitial) return null;

    if (authState is Unauthenticated || authState is AuthError) {
      return isOnLogin ? null : AppRoutes.login;
    }

    if (authState is Authenticated && isOnLogin) {
      return AppRoutes.home;
    }

    return null;
  },

  routes: [
    GoRoute(
      path: AppRoutes.login,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.guide,
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Pàgina Guía'))),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.explore,
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Pàgina Explora')),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const _ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.settings,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: AppRoutes.observing,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ObservingPage(),
    ),
    GoRoute(
      path: AppRoutes.review,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ReviewPage(),
    ),
  ],
);

// Temporary profile page with sign-out button.
// Replace with a proper ProfilePage widget when the profile feature is built.
class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Center(
        child: TextButton.icon(
          onPressed: () =>
              context.read<AuthBloc>().add(const SignOutRequested()),
          icon: const Icon(Icons.logout),
          label: const Text('Tanca la sessió'),
        ),
      ),
    );
  }
}
