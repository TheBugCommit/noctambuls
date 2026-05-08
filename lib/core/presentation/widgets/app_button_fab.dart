import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

enum AppButtonFabStyle { primary, secondary, tertiary, surface }

enum AppButtonFabSize { sm, md, lg }

class AppButtonFab extends StatelessWidget {
  const AppButtonFab._({
    required this.onPressed,
    required this.icon,
    this.heroTag,
    this.label,
    this.style = AppButtonFabStyle.primary,
    this.size = AppButtonFabSize.md,
  });

  factory AppButtonFab.small({
    required VoidCallback? onPressed,
    required IconData icon,
    Object? heroTag,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    style: style,
    heroTag: heroTag,
    size: AppButtonFabSize.sm,
  );

  factory AppButtonFab.regular({
    required VoidCallback? onPressed,
    required IconData icon,
    Object? heroTag,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    heroTag: heroTag,
    style: style,
  );

  factory AppButtonFab.large({
    required VoidCallback? onPressed,
    required IconData icon,
    Object? heroTag,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    style: style,
    heroTag: heroTag,
    size: AppButtonFabSize.lg,
  );

  factory AppButtonFab.extended({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    Object? heroTag,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    label: label,
    heroTag: heroTag,
    style: style,
  );

  final VoidCallback? onPressed;
  final IconData icon;
  final String? label;
  final AppButtonFabStyle style;
  final AppButtonFabSize size;
  final Object? heroTag;

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
      AppButtonFabSize.md => AppDimensions.iconLg,
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
        heroTag: heroTag,
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
        heroTag: heroTag,
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
          heroTag: heroTag,
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: shape,
          child: Icon(icon, size: iconSize),
        ),
      ),

      _ => FloatingActionButton(
        onPressed: onPressed,
        heroTag: heroTag,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: shape,
        child: Icon(icon, size: iconSize),
      ),
    };
  }
}
