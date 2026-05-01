import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/widgets/app_button.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class CatalogSyncRequiredView extends StatelessWidget {
  const CatalogSyncRequiredView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogSyncBloc, CatalogSyncState>(
      builder: (context, syncState) {
        if (syncState is CatalogSyncInProgress) {
          return const _LoadingView();
        }

        if (syncState is CatalogSyncFailure) {
          return const _FailureView();
        }

        return const _InitialView();
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppDimensions.md),
          Text(
            l10n.downloadingCatalog,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return _ActionRequiredWidget(
      icon: Icons.cloud_off_rounded,
      iconColor: Theme.of(context).colorScheme.error,
      title: l10n.connectionError,
      subtitle: l10n.catalogDownloadError,
      buttonLabel: l10n.retry,
      buttonIcon: Icons.refresh,
    );
  }
}

class _InitialView extends StatelessWidget {
  const _InitialView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return _ActionRequiredWidget(
      icon: Icons.download_rounded,
      iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
      title: l10n.requiredBirdCatalog,
      subtitle: l10n.requiredBirdCatalogMsg,
      buttonLabel: l10n.downloadNow,
      buttonIcon: Icons.download,
    );
  }
}

class _ActionRequiredWidget extends StatelessWidget {
  const _ActionRequiredWidget({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.buttonIcon,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final IconData buttonIcon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDimensions.xxl,
              color: iconColor,
            ),
            const SizedBox(height: AppDimensions.md),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.sm),
            Text(
              subtitle,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.lg),
            AppButton.primary(
              label: buttonLabel,
              icon: buttonIcon,
              onPressed: () => context.read<CatalogSyncBloc>().add(
                const CatalogSyncEventRequest(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
