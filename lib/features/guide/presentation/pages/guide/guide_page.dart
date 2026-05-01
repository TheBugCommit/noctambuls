import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/widgets/app_sheet.dart';
import 'package:noctambuls/core/widgets/taxus_app_bar.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_state.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_list.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/catalog_sync_requiered_view.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_cubit.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_state.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({
    required this.blocBuilder,
    super.key,
  });

  final GuideBloc Function() blocBuilder;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => blocBuilder()..add(LoadBirds(languageCode: languageCode)),
      child: const _GuideView(),
    );
  }
}

class _GuideView extends StatelessWidget {
  const _GuideView();

  Future<void> _showAudioWarningModal(
    BuildContext context,
    String audioPath,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final shouldPlay = await AppSheet.showConfirm(
      context: context,
      title: l10n.usage_warning_title,
      message: l10n.usage_warning_message,
      confirmText: l10n.usage_warning_confirm,
      cancelText: l10n.cancel,
    );

    if (shouldPlay == true && context.mounted) {
      context.read<GuideBloc>().add(
        AcceptAudioWarningAndPlay(audioPath: audioPath),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LanguageCubit, LanguageState>(
          listener: (context, state) {
            final newLanguageCode = state.appLanguage.toLanguageCode;
            context.read<GuideBloc>().add(
              LoadBirds(languageCode: newLanguageCode),
            );
          },
        ),
        BlocListener<CatalogSyncBloc, CatalogSyncState>(
          listenWhen: (previous, current) =>
              previous is CatalogSyncInProgress &&
              current is CatalogSyncSuccess,
          listener: (context, state) {
            final languageCode = Localizations.localeOf(context).languageCode;
            context.read<GuideBloc>().add(
              LoadBirds(languageCode: languageCode),
            );
          },
        ),
        BlocListener<GuideBloc, GuideState>(
          listenWhen: (previous, current) {
            if (previous is GuideLoaded && current is GuideLoaded) {
              return (previous.actionError != current.actionError &&
                      current.actionError != null) ||
                  (previous.action != current.action && current.action != null);
            }
            return false;
          },
          listener: (context, state) {
            if (state is GuideLoaded &&
                (state.actionError != null || state.action != null)) {
              final l10n = AppLocalizations.of(context)!;

              final action = state.action;
              if (action is GuideAudioWarning) {
                unawaited(_showAudioWarningModal(context, action.audioPath));
              }

              final error = state.actionError;
              if (error != null) {
                final errorMessage = switch (error) {
                  GuideUrlError() => l10n.cantOpenLink,
                  GuideAudioError() => l10n.cantPlayAudio,
                };

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMessage)),
                );
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: const TaxusAppBar(),
        body: BlocBuilder<GuideBloc, GuideState>(
          builder: (context, state) => switch (state) {
            GuideInitial() || GuideLoading() => const _GuideLoadingView(),
            GuideLoaded(:final birds) => BirdList(birds: birds),
            GuideError() => const _GuideErrorView(),
            GuideEmptyNeedsSync() => const CatalogSyncRequiredView(),
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
