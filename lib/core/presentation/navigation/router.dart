import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/presentation/navigation/go_router_refresh_stream.dart';
import 'package:noctambuls/core/presentation/pages/main_navigation_screen.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/auth/presentation/pages/signin/sign_in_page.dart';
import 'package:noctambuls/features/auth/presentation/pages/signup/sign_up_page.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/guide_page.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/home_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_bloc.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/observation_form_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/observing_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/review_page.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:noctambuls/features/profile/presentation/pages/profile/profile_page.dart';
import 'package:noctambuls/features/settings/presentation/pages/settings_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter makeRouter(AuthBloc authBloc) => GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.signin,
  refreshListenable: GoRouterRefreshStream(authBloc.stream),
  redirect: (context, state) {
    final authState = authBloc.state;
    final isOnSignIn = state.matchedLocation == AppRoutes.signin;
    final isOnSignUp = state.matchedLocation == AppRoutes.signup;

    if (authState is AuthInitial || authState is AuthLoading) return null;

    FlutterNativeSplash.remove();

    if (authState is Unauthenticated || authState is AuthError) {
      if (isOnSignIn) return null;
      return AppRoutes.signin;
    }

    if (authState is AuthRequiresProfile) {
      if (isOnSignUp) return null;
      return AppRoutes.signup;
    }

    if (authState is Authenticated) {
      if (isOnSignIn || isOnSignUp) return AppRoutes.home;
    }

    return null;
  },

  routes: [
    GoRoute(
      path: AppRoutes.signin,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SignUpPage(),
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
              builder: (context, state) => GuidePage(
                blocBuilder: sl.call,
              ),
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
              builder: (context, state) {
                return BlocProvider(
                  create: (_) =>
                      sl<SessionListBloc>()..add(WatchAllSessionsRequested()),
                  child: const ProfilePage(),
                );
              },
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
      path: AppRoutes.observationForm,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final args = state.extra! as ObservationFormArgs;

        return MaterialPage(
          fullscreenDialog: true,
          child: BlocProvider(
            create: (_) => sl<ObservationFormBloc>(),
            child: ObservationFormPage(
              sessionId: args.sessionId,
              sessionBloc: args.sessionBloc,
              existingRecord: args.existingRecord,
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.review,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ReviewPage(),
    ),
    GoRoute(
      path: AppRoutes.profileEdit,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final profileState = context.read<ProfileBloc>().state;
        final profile = profileState.currentProfile;

        if (profile == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return EditProfilePage(profile: profile);
      },
    ),
  ],
);
