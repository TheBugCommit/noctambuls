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

/*class CompassDialog extends StatelessWidget {
  const CompassDialog({super.key});

  String _getCardinalDirection(double bearing) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = (((bearing + 22.5) % 360) / 45).floor();
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(
        l10n.orientationTitle,
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: StreamBuilder<CompassEvent>(
          stream: FlutterCompass.events,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(l10n.compassError);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final heading = snapshot.data?.heading;

            if (heading == null) {
              return Text(l10n.compassNoSensor);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CompassDial(heading: heading),

                const SizedBox(height: AppDimensions.xl),

                Text(
                  '${heading.toStringAsFixed(0)}° ${_getCardinalDirection(heading)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppDimensions.sm),

                Text(
                  l10n.compassInstruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: AppDimensions.xl),

                AppButton.primary(
                  onPressed: () => Navigator.of(context).pop(heading),
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

class CompassDial extends StatelessWidget {
  const CompassDial({required this.heading, super.key});

  final double heading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),

          Transform.rotate(
            angle: heading * (math.pi / 180) * -1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                for (int i = 0; i < 360; i += 15)
                  CompassTick(
                    angle: i.toDouble(),
                    isMajor: i % 90 == 0,
                  ),

                CompassLetter(
                  text: 'N',
                  angle: 0,
                  heading: heading,
                  color: Colors.red,
                ),
                CompassLetter(text: 'E', angle: 90, heading: heading),
                CompassLetter(text: 'S', angle: 180, heading: heading),
                CompassLetter(text: 'W', angle: 270, heading: heading),
              ],
            ),
          ),

          const Icon(
            Icons.navigation,
            size: 64,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class CompassTick extends StatelessWidget {
  const CompassTick({
    required this.angle,
    required this.isMajor,
    super.key,
  });

  final double angle;
  final bool isMajor;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * math.pi / 180,
      child: Transform.translate(
        offset: const Offset(0, -100),
        child: Container(
          width: isMajor ? 3 : 1,
          height: isMajor ? 12 : 8,
          color: angle == 0 ? Colors.red : Colors.grey.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class CompassLetter extends StatelessWidget {
  const CompassLetter({
    required this.text,
    required this.angle,
    required this.heading,
    this.color,
    super.key,
  });

  final String text;
  final double angle;
  final double heading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * math.pi / 180,
      child: Transform.translate(
        offset: const Offset(0, -70),
        child: Transform.rotate(
          angle: (heading - angle) * (math.pi / 180),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color ?? Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}*/
