import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/compass_dialog.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/live_compass_preview.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class OrientationSelectorField extends StatelessWidget {
  const OrientationSelectorField({
    required this.selectedBearing,
    required this.onChanged,
    super.key,
  });

  final double? selectedBearing;
  final ValueChanged<double> onChanged;

  String _getCardinalDirection(double bearing) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = (((bearing + 22.5) % 360) / 45).floor();
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return FormField<double>(
      initialValue: selectedBearing,
      validator: (value) =>
          selectedBearing == null ? l10n.orientationRequired : null,
      builder: (formFieldState) {
        return Column(
          children: [
            InkWell(
              // Si vols, pots afegir un borderRadius aquí perquè l'efecte "ripple" en fer clic sigui arrodonit:
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              onTap: () async {
                final result = await showDialog<double>(
                  context: context,
                  builder: (context) => const CompassDialog(),
                );
                if (result != null) {
                  onChanged(result);
                  formFieldState.didChange(result);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.sm),
                child: Column(
                  children: [
                    LiveCompassPreview(
                      size: 130,
                      fixedHeading: selectedBearing,
                    ),
                    const SizedBox(height: AppDimensions.md),

                    Text(
                      selectedBearing != null
                          ? l10n.orientationValueLong(
                              _getCardinalDirection(selectedBearing!),
                              selectedBearing!.toStringAsFixed(0),
                            )
                          : l10n.orientationHint,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: selectedBearing != null
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurfaceVariant,
                        fontWeight: selectedBearing != null
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: AppDimensions.md),
                child: Text(
                  formFieldState.errorText!,
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: theme.textTheme.labelLarge?.fontSize,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
