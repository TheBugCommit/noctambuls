import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/presentation/bloc/audio/audio_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/phone_settings/phone_settings_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/share/share_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/navigation/auth_router_guard.dart';
import 'package:noctambuls/core/presentation/navigation/go_router_refresh_stream.dart';
import 'package:noctambuls/core/presentation/pages/main_navigation_screen.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/pages/signin/sign_in_page.dart';
import 'package:noctambuls/features/auth/presentation/pages/signup/sign_up_page.dart';
import 'package:noctambuls/features/auth/presentation/pages/splash/splash_page.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_event.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/guide_page.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_list_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/home_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/map_picker/map_picker_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_bloc.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/observation_form_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/observing_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/qr_scanner_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/review_page.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:noctambuls/features/profile/presentation/pages/profile/profile_page.dart';
import 'package:noctambuls/features/settings/presentation/pages/settings_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter makeRouter(AuthBloc authBloc) => GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  refreshListenable: GoRouterRefreshStream(authBloc.stream),
  redirect: (context, state) {
    FlutterNativeSplash.remove();
    return AuthRouterGuard.redirect(state, authBloc.state);
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
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<UrlBloc>(),
          child: const SignUpPage(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.splash,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SplashPage(),
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
              builder: (context, state) {
                final languageCode = Localizations.localeOf(
                  context,
                ).languageCode;

                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<AudioBloc>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<UrlBloc>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<GuideBloc>()
                        ..add(
                          LoadBirds(languageCode: languageCode),
                        ),
                    ),
                  ],
                  child: const GuidePage(),
                );
              },
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
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<UrlBloc>()),
            BlocProvider(create: (context) => sl<ShareBloc>()),
          ],
          child: const SettingsPage(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.observing,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<PhoneSettingsBloc>(),
          child: const ObservingPage(),
        );
      },
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
              session: args.session,
              sessionBloc: args.sessionBloc,
              globalDate: args.globalDate,
              onGlobalDateChanged: args.onGlobalDateChanged,
              existingRecord: args.existingRecord,
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.review,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final sessionToReview = state.extra as ObservationSession?;

        if (sessionToReview == null) {
          return const Scaffold(
            body: Center(child: Text('Error carregant revisió')),
          );
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<SessionReviewBloc>(param1: sessionToReview),
            ),
            BlocProvider(create: (_) => sl<PhoneSettingsBloc>()),
          ],
          child: ReviewPage(session: sessionToReview),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.qrScanner,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const QrScannerPage(),
    ),
    GoRoute(
      path: AppRoutes.mapPicker,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<UrlBloc>(),
          child: MapPickerPage(
            initialLocation: state.extra as GeoPosition?,
          ),
        );
      },
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
