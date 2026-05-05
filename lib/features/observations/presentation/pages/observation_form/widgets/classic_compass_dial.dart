import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

class ClassicCompassDial extends StatelessWidget {
  const ClassicCompassDial({
    required this.heading,
    super.key,
    this.size = 240,
  });

  final double heading;
  final double size;

  @override
  Widget build(BuildContext context) {
    final radius = size / 2;

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CompassBackground(size: size),

          Transform.rotate(
            angle: heading * (math.pi / 180) * -1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CompassTicksList(radius: radius),

                CompassLetter(
                  text: 'N',
                  angle: 0,
                  heading: heading,
                  radius: radius,
                  isPrimary: true,
                ),
                CompassLetter(
                  text: 'E',
                  angle: 90,
                  heading: heading,
                  radius: radius,
                ),
                CompassLetter(
                  text: 'S',
                  angle: 180,
                  heading: heading,
                  radius: radius,
                ),
                CompassLetter(
                  text: 'W',
                  angle: 270,
                  heading: heading,
                  radius: radius,
                ),
              ],
            ),
          ),

          CompassCenterNeedle(size: size),
        ],
      ),
    );
  }
}

class CompassBackground extends StatelessWidget {
  const CompassBackground({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    final dialSize = size * 0.91;

    return Container(
      width: dialSize,
      height: dialSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.surface,
        border: isDarkMode
            ? Border.all(color: colorScheme.outlineVariant)
            : null,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: isDarkMode ? 0.4 : 0.1),
            blurRadius: isDarkMode ? AppDimensions.md : AppDimensions.radiusSm,
            spreadRadius: AppDimensions.xs / 2,
          ),
        ],
      ),
    );
  }
}

class CompassTicksList extends StatelessWidget {
  const CompassTicksList({required this.radius, super.key});

  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        for (int i = 0; i < 360; i += 15)
          CompassTick(
            angle: i.toDouble(),
            isMajor: i % 90 == 0,
            radius: radius,
            color: i == 0
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
          ),
      ],
    );
  }
}

class CompassTick extends StatelessWidget {
  const CompassTick({
    required this.angle,
    required this.isMajor,
    required this.radius,
    required this.color,
    super.key,
  });

  final double angle;
  final bool isMajor;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * math.pi / 180,
      child: Transform.translate(
        offset: Offset(0, -radius * 0.83),
        child: Container(
          width: isMajor ? AppDimensions.xs * 0.75 : AppDimensions.xs * 0.25,
          height: isMajor ? AppDimensions.radiusMd : AppDimensions.radiusSm,
          color: color,
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
    required this.radius,
    this.isPrimary = false,
    super.key,
  });

  final String text;
  final double angle;
  final double heading;
  final double radius;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Transform.rotate(
      angle: angle * math.pi / 180,
      child: Transform.translate(
        offset: Offset(0, -radius * 0.58),
        child: Transform.rotate(
          angle: (heading - angle) * (math.pi / 180),
          child: Text(
            text,
            style: TextStyle(
              fontSize: radius * 0.2,
              fontWeight: FontWeight.bold,
              color: isPrimary
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class CompassCenterNeedle extends StatelessWidget {
  const CompassCenterNeedle({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.navigation,
      size: size * 0.26,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
