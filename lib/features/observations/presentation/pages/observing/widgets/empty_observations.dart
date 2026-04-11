import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class EmptyObservations extends StatelessWidget {
  const EmptyObservations({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.biotech_outlined,
            size: AppDimensions.xxl * 1.5,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: AppDimensions.md),
          Text(
            l10n.noObservationsRegistered,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
