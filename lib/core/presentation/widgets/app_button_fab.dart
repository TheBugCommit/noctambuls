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
    this.isDisabled = false,
  });

  factory AppButtonFab.small({
    required VoidCallback? onPressed,
    required IconData icon,
    Object? heroTag,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
    bool isDisabled = false,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    style: style,
    heroTag: heroTag,
    size: AppButtonFabSize.sm,
    isDisabled: isDisabled,
  );

  factory AppButtonFab.regular({
    required VoidCallback? onPressed,
    required IconData icon,
    Object? heroTag,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
    bool isDisabled = false,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    heroTag: heroTag,
    style: style,
    isDisabled: isDisabled,
  );

  factory AppButtonFab.large({
    required VoidCallback? onPressed,
    required IconData icon,
    Object? heroTag,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
    bool isDisabled = false,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    style: style,
    heroTag: heroTag,
    size: AppButtonFabSize.lg,
    isDisabled: isDisabled,
  );

  factory AppButtonFab.extended({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    Object? heroTag,
    AppButtonFabStyle style = AppButtonFabStyle.primary,
    bool isDisabled = false,
  }) => AppButtonFab._(
    onPressed: onPressed,
    icon: icon,
    label: label,
    heroTag: heroTag,
    style: style,
    isDisabled: isDisabled,
  );

  final VoidCallback? onPressed;
  final IconData icon;
  final String? label;
  final AppButtonFabStyle style;
  final AppButtonFabSize size;
  final Object? heroTag;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final reallyDisabled = isDisabled || onPressed == null;

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

    final finalBgColor = reallyDisabled
        ? colorScheme.onSurface.withValues(alpha: 0.12)
        : bgColor;

    final finalFgColor = reallyDisabled
        ? colorScheme.onSurface.withValues(alpha: 0.38)
        : fgColor;

    final finalOnPressed = reallyDisabled ? null : onPressed;

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
        onPressed: finalOnPressed,
        heroTag: heroTag,
        backgroundColor: finalBgColor,
        foregroundColor: finalFgColor,
        elevation: reallyDisabled ? 0 : null,
        shape: shape,
        icon: Icon(icon, size: iconSize),
        label: Text(label!),
      );
    }

    return switch (size) {
      AppButtonFabSize.sm => FloatingActionButton.small(
        onPressed: finalOnPressed,
        heroTag: heroTag,
        backgroundColor: finalBgColor,
        foregroundColor: finalFgColor,
        elevation: reallyDisabled ? 0 : null,
        shape: shape,
        child: Icon(icon, size: iconSize),
      ),

      AppButtonFabSize.lg => SizedBox(
        width: AppDimensions.buttonHeightXl,
        height: AppDimensions.buttonHeightXl,
        child: FloatingActionButton(
          onPressed: finalOnPressed,
          heroTag: heroTag,
          backgroundColor: finalBgColor,
          foregroundColor: finalFgColor,
          elevation: reallyDisabled ? 0 : null,
          shape: shape,
          child: Icon(icon, size: iconSize),
        ),
      ),

      _ => FloatingActionButton(
        onPressed: finalOnPressed,
        heroTag: heroTag,
        backgroundColor: finalBgColor,
        foregroundColor: finalFgColor,
        elevation: reallyDisabled ? 0 : null,
        shape: shape,
        child: Icon(icon, size: iconSize),
      ),
    };
  }
}
