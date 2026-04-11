import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

enum AppButtonFabStyle { primary, secondary, tertiary, surface }

enum AppButtonFabSize { sm, md, lg }

class AppButtonFab extends StatelessWidget {
  const AppButtonFab._({
    required this.onPressed,
    required this.icon,
    this.label,
    this.style = AppButtonFabStyle.primary,
    this.size = AppButtonFabSize.md,
    super.key,
  });

  factory AppButtonFab.small({
    required VoidCallback? onPressed,
    required IconData icon,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    style: style,
    size: AppButtonFabSize.sm,
  );

  factory AppButtonFab.regular({
    required VoidCallback? onPressed,
    required IconData icon,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    style: style,
    size: AppButtonFabSize.md,
  );

  factory AppButtonFab.large({
    required VoidCallback? onPressed,
    required IconData icon,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    style: style,
    size: AppButtonFabSize.lg,
  );

  factory AppButtonFab.extended({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    label: label,
    style: style,
    size: AppButtonFabSize.md,
  );

  final VoidCallback? onPressed;
  final IconData icon;
  final String? label;
  final AppButtonFabStyle style;
  final AppButtonFabSize size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (bgColor, fgColor) = switch (style) {
      AppButtonFabStyle.primary => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
      ),
      AppButtonFabStyle.secondary => (
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
      ),
      AppButtonFabStyle.tertiary => (
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
      ),
      AppButtonFabStyle.surface => (
        colorScheme.surfaceContainerHigh,
        colorScheme.primary,
      ),
    };

    final iconSize = switch (size) {
      AppButtonFabSize.sm => AppDimensions.iconSm,
      AppButtonFabSize.md => AppDimensions.iconMd,
      AppButtonFabSize.lg => AppDimensions.iconXl,
    };

    final borderRadius = switch (size) {
      AppButtonFabSize.sm => AppDimensions.radiusMd,
      AppButtonFabSize.md => AppDimensions.radiusLg,
      AppButtonFabSize.lg => AppDimensions.radiusXl,
    };

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    if (label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: shape,
        icon: Icon(icon, size: iconSize),
        label: Text(label!),
      );
    }

    return switch (size) {
      AppButtonFabSize.sm => FloatingActionButton.small(
        onPressed: onPressed,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: shape,
        child: Icon(icon, size: iconSize),
      ),

      AppButtonFabSize.lg => SizedBox(
        width: AppDimensions.buttonHeightXl,
        height: AppDimensions.buttonHeightXl,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: shape,
          child: Icon(icon, size: iconSize),
        ),
      ),

      _ => FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: shape,
        child: Icon(icon, size: iconSize),
      ),
    };
  }
}
