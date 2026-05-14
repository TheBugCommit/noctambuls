import 'package:flutter/material.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

extension ObservationSessionExtension on ObservationSession {
  String statusLabel(AppLocalizations l10n) {
    if (isObserving) return l10n.statusObserving;
    if (isReviewing) return l10n.statusReviewing;

    return switch (syncStatus) {
      SyncStatus.draft => l10n.statusDraft,
      SyncStatus.pending => l10n.statusPending,
      SyncStatus.syncing => l10n.statusSyncing,
      SyncStatus.synced => l10n.statusSynced,
      SyncStatus.error => l10n.statusSyncError,
    };
  }

  /// Retorna el color de fons per l'etiqueta d'estat
  Color statusBackgroundColor(ColorScheme colorScheme) {
    if (isObserving) return colorScheme.primaryContainer;
    if (isReviewing) return colorScheme.tertiaryContainer;

    return switch (syncStatus) {
      SyncStatus.draft => colorScheme.surfaceContainerHighest,
      SyncStatus.pending => colorScheme.secondaryContainer,
      SyncStatus.syncing => colorScheme.tertiaryContainer,
      SyncStatus.synced => colorScheme.primaryContainer,
      SyncStatus.error => colorScheme.errorContainer,
    };
  }

  /// Retorna el color del text/icona per l'etiqueta d'estat
  Color statusTextColor(ColorScheme colorScheme) {
    if (isObserving) return colorScheme.onPrimaryContainer;
    if (isReviewing) return colorScheme.onTertiaryContainer;

    return switch (syncStatus) {
      SyncStatus.draft => colorScheme.onSurfaceVariant,
      SyncStatus.pending => colorScheme.onSecondaryContainer,
      SyncStatus.syncing => colorScheme.onTertiaryContainer,
      SyncStatus.synced => colorScheme.primary,
      SyncStatus.error => colorScheme.onErrorContainer,
    };
  }

  IconData statusIcon() {
    if (isObserving) return Icons.play_circle_outline;
    if (isReviewing) return Icons.fact_check_outlined;

    return switch (syncStatus) {
      SyncStatus.draft => Icons.edit_note,
      SyncStatus.pending => Icons.cloud_upload_outlined,
      SyncStatus.syncing => Icons.sync,
      SyncStatus.synced => Icons.cloud_done_outlined,
      SyncStatus.error => Icons.error_outline,
    };
  }
}
