import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart'; // NOU IMPORT
import 'package:noctambuls/core/presentation/widgets/time_text.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class CensusLobbyCard extends StatelessWidget {
  const CensusLobbyCard({
    required this.census,
    required this.onEnter,
    required this.onAbandon,
    super.key,
  });

  final Census census;
  final VoidCallback onEnter;
  final VoidCallback onAbandon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.sm),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      elevation: 0,
      child: Material(
        color: colorScheme.surfaceContainerLow,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.hourglass_top_rounded,
                        color: colorScheme.secondary,
                        size: AppDimensions.iconSm,
                      ),
                      const SizedBox(width: AppDimensions.xs),
                      Text(
                        l10n.censusLobbyWaiting.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),

                  AppButton(
                    onPressed: onAbandon,
                    icon: Icons.close_rounded,
                    style: AppButtonStyle.ghost,
                    size: AppButtonSize.sm,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.xs),

              Text(
                census.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppDimensions.xs),

              Row(
                children: [
                  Icon(
                    Icons.event_outlined,
                    size: AppDimensions.iconXs,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppDimensions.xs),
                  TimeText.dateTime(
                    census.startTime,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.lg),

              SizedBox(
                width: double.infinity,
                child: AppButton.primary(
                  onPressed: onEnter,
                  icon: Icons.play_arrow_rounded,
                  label: l10n.censusEnterLobby,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
