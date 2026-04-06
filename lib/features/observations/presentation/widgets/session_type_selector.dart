import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SessionTypeSelector extends StatelessWidget {
  const SessionTypeSelector({required this.onTypeSelected, super.key});

  final void Function(SessionType) onTypeSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _SessionTypeButton(
              title: l10n.censusLabel,
              icon: Icons.groups_outlined,
              cardColor: colorScheme.primary,
              onColor: colorScheme.onPrimary,
              onTap: () => onTypeSelected(SessionType.census),
            ),
          ),
          const SizedBox(width: AppDimensions.md),
          Expanded(
            child: _SessionTypeButton(
              title: l10n.stationLabel,
              icon: Icons.person_pin_circle_outlined,
              cardColor: colorScheme.secondary,
              onColor: colorScheme.onSecondary,
              onTap: () => onTypeSelected(SessionType.station),
            ),
          ),
          const SizedBox(width: AppDimensions.md),
          Expanded(
            child: _SessionTypeButton(
              title: l10n.incidentalLabel,
              icon: Icons.visibility_outlined,
              cardColor: colorScheme.tertiary,
              onColor: colorScheme.onTertiary,
              onTap: () => onTypeSelected(SessionType.incidental),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionTypeButton extends StatelessWidget {
  const _SessionTypeButton({
    required this.title,
    required this.icon,
    required this.cardColor,
    required this.onColor,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color cardColor;
  final Color onColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Material(
            color: cardColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Icon(icon, size: 36, color: onColor),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.sm),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
