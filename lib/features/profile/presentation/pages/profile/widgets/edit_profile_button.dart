import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      icon: const Icon(Icons.edit_outlined),
      tooltip: l10n.profileEditTitle,
      onPressed: () => context.push(AppRoutes.profileEdit),
      style: IconButton.styleFrom(
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        padding: const EdgeInsets.all(AppDimensions.sm),
      ),
    );
  }
}
