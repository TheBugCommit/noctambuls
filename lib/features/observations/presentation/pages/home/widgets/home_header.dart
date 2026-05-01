import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/widgets/app_sheet.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/widgets/observation_methods_info_sheet.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  Future<void> showInfoSheet(BuildContext context) async {
    await AppSheet.show<void>(
      context: context,
      child: const ObservationMethodsInfoSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          l10n.homeTitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () => showInfoSheet(context),
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            padding: const EdgeInsets.all(AppDimensions.sm),
          ),
        ),
      ],
    );
  }
}
