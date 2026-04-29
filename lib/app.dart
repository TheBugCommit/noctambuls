import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/theme/theme.dart';
import 'package:noctambuls/core/theme/util.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_cubit.dart';
import 'package:noctambuls/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';
import 'package:noctambuls/features/settings/presentation/utils/theme_mapper.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class NoctambulsApp extends StatelessWidget {
  const NoctambulsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context);
    final myTheme = MaterialTheme(textTheme);

    final themeState = context.watch<ThemeCubit>().state;
    final langState = context.watch<LanguageCubit>().state;

    final router = sl<GoRouter>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.read<CatalogSyncBloc>().add(const CatalogSyncEventRequest());
          context.read<SessionLifecycleBloc>().add(WatchSession());
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,

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
