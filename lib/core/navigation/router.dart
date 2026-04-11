import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/navigation/main_navigation_screen.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/home_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/observing_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/review_page.dart';
import 'package:noctambuls/features/settings/presentation/pages/settings_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
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
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Pàgina Explora'))),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Pàgina Perfil'))),
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
