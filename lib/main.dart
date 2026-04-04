import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/app.dart';
import 'package:noctambuls/core/di/injection_container.dart' as di;
import 'package:noctambuls/features/settings/presentation/cubit/language_cubit.dart';
import 'package:noctambuls/features/settings/presentation/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ThemeCubit>()),
        BlocProvider(create: (_) => di.sl<LanguageCubit>()),
      ],
      child: const NoctambulsApp(),
    ),
  );
}
