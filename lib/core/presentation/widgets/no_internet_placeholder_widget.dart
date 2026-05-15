import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class NoInternetPlaceholderWidget extends StatelessWidget {
  const NoInternetPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_outlined,
            size: AppDimensions.iconXl,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppDimensions.sm),
          Text(
            l10n.reviewLocationNoInternet,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppDimensions.xs),
          Text(
            l10n.reviewLocationNoInternetDesc,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
