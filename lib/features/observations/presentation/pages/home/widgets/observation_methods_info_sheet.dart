import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ObservationMethodsInfoSheet extends StatelessWidget {
  const ObservationMethodsInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppBottomSheet(
      title: l10n.observingMethodTitle,
      content: const _ObservationMethodsContent(),
      primaryButton: AppButton.primary(
        label: l10n.observingMethodConfirmLabel,
        onPressed: () => context.pop(),
      ),
    );
  }
}

class _ObservationMethodsContent extends StatelessWidget {
  const _ObservationMethodsContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _MethodItem(
          icon: Icons.groups_outlined,
          title: l10n.observingMethodCensTitle,
          description: l10n.observingMethodCensDescription,
        ),
        const SizedBox(height: AppDimensions.lg),
        _MethodItem(
          icon: Icons.person_pin_circle_outlined,
          title: l10n.observingMethodESTitle,
          description: l10n.observingMethodESDescription,
        ),
        const SizedBox(height: AppDimensions.lg),
        _MethodItem(
          icon: Icons.visibility_outlined,
          title: l10n.observingMethodIncTitle,
          description: l10n.observingMethodIncDescription,
        ),
      ],
    );
  }
}

class _MethodItem extends StatelessWidget {
  const _MethodItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconLg,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppDimensions.sm),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.sm),
        Text(
          description,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
