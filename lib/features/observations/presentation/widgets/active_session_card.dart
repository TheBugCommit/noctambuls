import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ActiveSessionCard extends StatelessWidget {
  const ActiveSessionCard({
    required this.session,
    required this.onResume,
    super.key,
  });

  final ObservationSession session;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final startTime = session.startTime != null
        ? '${session.startTime!.hour.toString().padLeft(2, '0')}:'
              '${session.startTime!.minute.toString().padLeft(2, '0')}'
        : '--:--';

    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.fiber_manual_record,
                  size: AppDimensions.md,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: AppDimensions.sm),
                Expanded(
                  child: Text(
                    l10n.startedAt(startTime),
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.sm),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onResume,
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(l10n.continueObserving),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
