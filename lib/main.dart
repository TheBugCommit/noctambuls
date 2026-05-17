import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:noctambuls/app.dart';
import 'package:noctambuls/core/background/fcm_background_handler.dart';
import 'package:noctambuls/core/background/work_manager_init.dart' as wm;
import 'package:noctambuls/core/data/services/fcm_service.dart';
import 'package:noctambuls/core/di/injection_container.dart' as di;
import 'package:noctambuls/features/settings/domain/usecases/get_notifications_enabled_usecase.dart';
import 'package:noctambuls/core/presentation/bloc/notification_inbox/notification_inbox_bloc.dart';
import 'package:noctambuls/core/utils/app_bloc_observer.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_event.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_bloc.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:noctambuls/firebase_options.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await di.init();
  final isNotificationsEnabled = di.sl<GetNotificationsEnabledUseCase>()();
  await di.sl<FcmService>().init(notificationsEnabled: isNotificationsEnabled);
  await wm.init();

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
        BlocProvider(
          create: (_) => di.sl<ObservingSessionBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<CensusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (_) =>
              di.sl<NotificationInboxBloc>()
                ..add(const NotificationInboxStarted()),
        ),
      ],
      child: const NoctambulsApp(),
    ),
  );
}
