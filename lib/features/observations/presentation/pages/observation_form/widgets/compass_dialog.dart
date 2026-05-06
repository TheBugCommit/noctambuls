import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/classic_compass_dial.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class CompassDialog extends StatelessWidget {
  const CompassDialog({super.key});

  String _getCardinalDirection(double bearing) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = (((bearing + 22.5) % 360) / 45).floor();
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Agafem el tema una sola vegada a l'inici
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(l10n.orientationTitle, textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: StreamBuilder<CompassEvent>(
          stream: FlutterCompass.events,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final heading = snapshot.data?.heading;
            if (heading == null) return Text(l10n.compassNoSensor);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. LA TEVA BRÚIXOLA EN GRAN (Ja utilitza el tema internament)
                ClassicCompassDial(
                  heading: heading,
                  size: 240, // Mida gran pel diàleg
                ),

                const SizedBox(height: AppDimensions.xl),

                // 2. Resultat Numèric (Amb el color primari del tema)
                Text(
                  '${heading.toStringAsFixed(0)}° ${_getCardinalDirection(heading)}',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(height: AppDimensions.sm),

                Text(
                  l10n.compassInstruction,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppDimensions.xl),

                AppButton.primary(
                  onPressed: () => context.pop(heading),
                  label: l10n.compassFixDirection,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
