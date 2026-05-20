import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/data/services/fcm_service.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/domain/services/notification_service.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/presentation/bloc/notification_inbox/notification_inbox_bloc.dart';
import 'package:noctambuls/core/presentation/theme/theme.dart';
import 'package:noctambuls/core/presentation/theme/util.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_bloc.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_event.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_event.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_notifications_enabled_usecase.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';
import 'package:noctambuls/features/settings/presentation/utils/theme_mapper.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class NoctambulsApp extends StatefulWidget {
  const NoctambulsApp({super.key});

  @override
  State<NoctambulsApp> createState() => _NoctambulsAppState();
}

class _NoctambulsAppState extends State<NoctambulsApp> {
  bool _hasInitializedSession = false;
  Timer? _notificationPermissionTimer;
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
  }

  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<NotificationInboxBloc>().add(
        const NotificationInboxRefreshed(),
      );
    }
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    _notificationPermissionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context);
    final myTheme = MaterialTheme(textTheme);

    final themeState = context.watch<ThemeBloc>().state;
    final langState = context.watch<LanguageBloc>().state;
    final router = sl<GoRouter>();

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              if (!_hasInitializedSession) {
                _hasInitializedSession = true;

                _notificationPermissionTimer = Timer(
                  const Duration(seconds: 40),
                  () async {
                    await sl<NotificationService>().requestPermissions();
                    final isEnabled = sl<GetNotificationsEnabledUseCase>()();
                    try {
                      if (isEnabled) {
                        await sl<FcmService>().subscribeToNotifications();
                      } else {
                        await sl<FcmService>().unsubscribeFromNotifications();
                      }
                    } catch (e) {
                      sl<IAppLogger>().warning(
                        'Timeout subscribing to notifications',
                      );
                    }
                  },
                );

                context.read<CatalogSyncBloc>().add(
                  const CatalogSyncEventRequest(showGlobalError: true),
                );
                context.read<ObservingSessionBloc>().add(
                  WatchObservingSession(),
                );
                context.read<CensusBloc>().add(CensusStarted());
                context.read<ProfileBloc>().add(
                  ProfileLoadRequested(userId: state.user.id),
                );
              }
            } else if (state is Unauthenticated) {
              _hasInitializedSession = false;
              _notificationPermissionTimer?.cancel();
            }
          },
        ),
        BlocListener<CatalogSyncBloc, CatalogSyncState>(
          listener: (context, state) {
            if (state is CatalogSyncSuccess) {
              context.read<ObservingSessionBloc>().add(
                const ObservingBirdsReloadRequested(),
              );
            }
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: child,
          );
        },

        themeMode: themeState.appTheme.toFlutterThemeMode,
        theme: myTheme.light(),
        darkTheme: myTheme.dark(),
        themeAnimationDuration: const Duration(milliseconds: 400),

        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        locale: langState.appLanguage.toFlutterLocale,

        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,

        localeResolutionCallback: (deviceLocale, supportedLocales) {
          if (deviceLocale != null) {
            for (final supported in supportedLocales) {
              if (supported.languageCode == deviceLocale.languageCode) {
                return deviceLocale;
              }
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
