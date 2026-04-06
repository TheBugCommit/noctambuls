import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/app.dart';
import 'package:noctambuls/core/di/injection_container.dart' as di;
import 'package:noctambuls/core/utils/app_bloc_observer.dart';
import 'package:noctambuls/features/observations/presentation/bloc/active_session_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/active_session_event.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_cubit.dart';
import 'package:noctambuls/features/settings/presentation/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ThemeCubit>()),
        BlocProvider(create: (_) => di.sl<LanguageCubit>()),
        BlocProvider(
          create: (_) =>
              di.sl<ActiveSessionBloc>()..add(StartWatchingActiveSession()),
        ),
      ],
      child: const NoctambulsApp(),
    ),
  );
}
