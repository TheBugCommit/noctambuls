import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:noctambuls/app.dart';
import 'package:noctambuls/core/di/injection_container.dart' as di;
import 'package:noctambuls/core/presentation/bloc/audio/audio_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/share/share_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/utils/app_bloc_observer.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_bloc.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await di.init();

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(const CheckStoredAuth()),
        ),
        BlocProvider(
          create: (_) => di.sl<CatalogSyncBloc>(),
        ),
        BlocProvider(create: (_) => di.sl<ThemeBloc>()),
        BlocProvider(create: (_) => di.sl<LanguageBloc>()),
        BlocProvider(create: (_) => di.sl<UrlBloc>()),
        BlocProvider(create: (_) => di.sl<AudioBloc>()),
        BlocProvider(
          create: (_) => di.sl<SessionLifecycleBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ProfileBloc>(),
        ),
        BlocProvider(create: (_) => di.sl<ShareBloc>()),
      ],
      child: const NoctambulsApp(),
    ),
  );
}
