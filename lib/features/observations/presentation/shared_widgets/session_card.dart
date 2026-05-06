import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/extensions/observation_session_extension.dart';
import 'package:noctambuls/core/presentation/extensions/session_type_extension.dart';
import 'package:noctambuls/core/presentation/widgets/time_text.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    required this.session,
    required this.onTap,
    super.key,
  });

  final ObservationSession session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: AppDimensions.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        // Podem destacar subtilment la vora si hi ha algun error de sincronització
        side: session.syncStatus == SyncStatus.error
            ? BorderSide(color: colorScheme.error.withValues(alpha: 0.5))
            : BorderSide.none,
      ),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. CAPÇALERA: Data i ETIQUETA D'ESTAT (Badge)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeText.dateTime(session.startTime ?? session.createdAt),

                  // El Badge d'estat aprofitant la nostra Extensió Visual
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.sm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: session.statusBackgroundColor(colorScheme),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusSm,
                      ),
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
                  ),
                ],
              ),

              const Divider(height: AppDimensions.xl),

              // 2. DETALLS: Tipus de sessió
              Row(
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
                            session.endTime!,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
