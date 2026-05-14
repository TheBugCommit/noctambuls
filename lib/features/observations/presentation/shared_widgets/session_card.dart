import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/extensions/observation_session_extension.dart';
import 'package:noctambuls/core/presentation/extensions/session_type_extension.dart';
import 'package:noctambuls/core/presentation/extensions/sync_error_type_extension.dart';
import 'package:noctambuls/core/presentation/widgets/time_text.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    required this.session,
    required this.onTap,
    this.onRetrySync,
    super.key,
  });

  final ObservationSession session;
  final VoidCallback onTap;
  final VoidCallback? onRetrySync;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSyncing = session.syncStatus == SyncStatus.syncing;
    final needsSyncAction =
        session.syncStatus == SyncStatus.error ||
        session.syncStatus == SyncStatus.pending;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: AppDimensions.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        side: session.syncStatus == SyncStatus.error
            ? BorderSide(color: colorScheme.error.withValues(alpha: 0.5))
            : BorderSide.none,
      ),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isSyncing)
              LinearProgressIndicator(
                minHeight: 3,
                backgroundColor: colorScheme.tertiaryContainer,
                color: colorScheme.tertiary,
              ),

            Padding(
              padding: const EdgeInsets.all(AppDimensions.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SessionHeader(session: session),
                  const Divider(height: AppDimensions.xl),
                  _SessionDetails(session: session),
                ],
              ),
            ),

            if (needsSyncAction)
              _SessionSyncFooter(
                session: session,
                onRetrySync: onRetrySync,
              ),
          ],
        ),
      ),
    );
  }
}

class _SessionHeader extends StatelessWidget {
  const _SessionHeader({required this.session});

  final ObservationSession session;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TimeText.dateTime(session.startTime ?? session.createdAt),
        _SessionStatusBadge(session: session),
      ],
    );
  }
}

class _SessionStatusBadge extends StatelessWidget {
  const _SessionStatusBadge({required this.session});

  final ObservationSession session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.sm,
        vertical: AppDimensions.xs,
      ),
      decoration: BoxDecoration(
        color: session.statusBackgroundColor(colorScheme),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            session.statusIcon(),
            size: AppDimensions.iconXs,
            color: session.statusTextColor(colorScheme),
          ),
          const SizedBox(width: AppDimensions.sm),
          Text(
            session.statusLabel(l10n),
            style: theme.textTheme.labelMedium?.copyWith(
              color: session.statusTextColor(colorScheme),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionDetails extends StatelessWidget {
  const _SessionDetails({required this.session});

  final ObservationSession session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(
          session.sessionType.icon(),
          size: AppDimensions.iconLg,
          color: colorScheme.primary,
        ),
        const SizedBox(width: AppDimensions.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session.sessionType.name(l10n),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (session.endTime != null)
                TimeText.dateTime(
                  session.endTime,
                  formatStyle: DateTimeFormatStyle.timeOnly,
                  prefixText: l10n.sessionCardEndsAt,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
        Icon(
          Icons.chevron_right,
          color: colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }
}

class _SessionSyncFooter extends StatelessWidget {
  const _SessionSyncFooter({
    required this.session,
    required this.onRetrySync,
  });

  final ObservationSession session;
  final VoidCallback? onRetrySync;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isError = session.syncStatus == SyncStatus.error;

    final errorMessage = session.syncError?.errorMessage(l10n);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.xs,
      ),
      decoration: BoxDecoration(
        color: isError
            ? colorScheme.errorContainer.withValues(alpha: 0.4)
            : colorScheme.secondaryContainer.withValues(alpha: 0.4),
        border: Border(
          top: BorderSide(
            color: isError
                ? colorScheme.error.withValues(alpha: 0.2)
                : colorScheme.secondary.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              errorMessage ?? l10n.statusPending,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isError
                    ? colorScheme.onErrorContainer
                    : colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onRetrySync != null)
            TextButton.icon(
              onPressed: onRetrySync,
              icon: const Icon(Icons.sync),
              label: Text(l10n.retry),
              style: TextButton.styleFrom(
                foregroundColor: isError
                    ? colorScheme.onErrorContainer
                    : colorScheme.onSecondaryContainer,
                visualDensity: VisualDensity.compact,
              ),
            ),
        ],
      ),
    );
  }
}
