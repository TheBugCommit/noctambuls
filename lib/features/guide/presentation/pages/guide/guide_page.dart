import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/widgets/taxus_app_bar.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_state.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_list.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_cubit.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_state.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) =>
          sl<GuideBloc>()..add(LoadBirds(languageCode: languageCode)),
      child: const _GuideView(),
    );
  }
}

class _GuideView extends StatelessWidget {
  const _GuideView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
      listener: (context, state) {
        final newLanguageCode = state.appLanguage.toLanguageCode;
        context.read<GuideBloc>().add(LoadBirds(languageCode: newLanguageCode));
      },
      child: Scaffold(
        appBar: const TaxusAppBar(),
        body: BlocBuilder<GuideBloc, GuideState>(
          builder: (context, state) => switch (state) {
            GuideInitial() || GuideLoading() => const _GuideLoadingView(),
            GuideLoaded(:final birds) => BirdList(birds: birds),
            GuideError() => const _GuideErrorView(),
          },
        ),
      ),
    );
  }
}

class _GuideLoadingView extends StatelessWidget {
  const _GuideLoadingView();

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

class _GuideErrorView extends StatelessWidget {
  const _GuideErrorView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.error_outline, size: AppDimensions.xxl),
    );
  }
}
