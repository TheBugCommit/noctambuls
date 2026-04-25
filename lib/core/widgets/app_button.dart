import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

enum AppButtonStyle {
  primary,
  secondary,
  tertiary,
  destructive,
  destructiveTonal,
  ghost,
  outline,
}

enum AppButtonSize { sm, md, lg, xl }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    this.label,
    this.icon,
    this.customIcon,
    this.style = AppButtonStyle.primary,
    this.size = AppButtonSize.md,
    super.key,
  }) : assert(
         label != null || icon != null || customIcon != null,
         'Either label or icon must be provided',
       );

  factory AppButton.primary({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    Widget? customIcon,
    AppButtonSize size = AppButtonSize.md,
  }) => AppButton(
    onPressed: onPressed,
    label: label,
    icon: icon,
    customIcon: customIcon,
    size: size,
    style: AppButtonStyle.primary,
  );

  factory AppButton.secondary({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    Widget? customIcon,
    AppButtonSize size = AppButtonSize.md,
  }) => AppButton(
    onPressed: onPressed,
    label: label,
    icon: icon,
    customIcon: customIcon,
    size: size,
    style: AppButtonStyle.secondary,
  );

  factory AppButton.outline({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    Widget? customIcon,
    AppButtonSize size = AppButtonSize.md,
  }) => AppButton(
    onPressed: onPressed,
    label: label,
    icon: icon,
    customIcon: customIcon,
    size: size,
    style: AppButtonStyle.outline,
  );

  factory AppButton.destructive({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    Widget? customIcon,
    AppButtonSize size = AppButtonSize.md,
  }) => AppButton(
    onPressed: onPressed,
    label: label,
    icon: icon,
    customIcon: customIcon,
    size: size,
    style: AppButtonStyle.destructive,
  );

  factory AppButton.destructiveSoft({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    Widget? customIcon,
    AppButtonSize size = AppButtonSize.md,
  }) => AppButton(
    onPressed: onPressed,
    label: label,
    icon: icon,
    customIcon: customIcon,
    size: size,
    style: AppButtonStyle.destructiveTonal,
  );

  final VoidCallback? onPressed;
  final String? label;
  final IconData? icon;
  final Widget? customIcon;
  final AppButtonStyle style;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (padding, textStyle, iconSize, exactHeight) = switch (size) {
      AppButtonSize.sm => (
        const EdgeInsets.symmetric(horizontal: AppDimensions.sm),
        theme.textTheme.labelLarge,
        AppDimensions.iconSm,
        AppDimensions.buttonHeightSm,
      ),
      AppButtonSize.md => (
        const EdgeInsets.symmetric(horizontal: AppDimensions.md),
        theme.textTheme.titleSmall,
        AppDimensions.iconMd,
        AppDimensions.buttonHeightMd,
      ),
      AppButtonSize.lg => (
        const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
        theme.textTheme.titleMedium,
        AppDimensions.iconLg,
        AppDimensions.buttonHeightLg,
      ),
      AppButtonSize.xl => (
        const EdgeInsets.symmetric(horizontal: AppDimensions.xl),
        theme.textTheme.headlineSmall,
        AppDimensions.iconXl,
        AppDimensions.buttonHeightXl,
      ),
    };

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
    );

    Widget buildNativeButton(Widget childWidget, {bool isIconOnly = false}) {
      final currentPadding = isIconOnly ? EdgeInsets.zero : padding;

      switch (style) {
        case AppButtonStyle.primary:
        case AppButtonStyle.secondary:
        case AppButtonStyle.tertiary:
        case AppButtonStyle.destructive:
        case AppButtonStyle.destructiveTonal:
          final (bgColor, fgColor) = switch (style) {
            AppButtonStyle.primary => (
              colorScheme.primary,
              colorScheme.onPrimary,
            ),
            AppButtonStyle.secondary => (
              colorScheme.secondaryContainer,
              colorScheme.onSecondaryContainer,
            ),
            AppButtonStyle.tertiary => (
              colorScheme.tertiaryContainer,
              colorScheme.onTertiaryContainer,
            ),
            AppButtonStyle.destructive => (
              colorScheme.error,
              colorScheme.onError,
            ),
            AppButtonStyle.destructiveTonal => (
              colorScheme.errorContainer,
              colorScheme.onErrorContainer,
            ),
            _ => (colorScheme.primary, colorScheme.onPrimary),
          };

          return FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: fgColor,
              padding: currentPadding,
              textStyle: textStyle,
              minimumSize: Size(0, exactHeight),
              shape: shape,
              elevation: 0,
            ),
            child: childWidget,
          );

        case AppButtonStyle.outline:
          return OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: colorScheme.primary,
              side: BorderSide(
                color: onPressed != null
                    ? colorScheme.outline
                    : colorScheme.onSurface.withValues(alpha: 0.12),
              ),
              padding: currentPadding,
              textStyle: textStyle,
              minimumSize: Size(0, exactHeight),
              shape: shape,
            ),
            child: childWidget,
          );

        case AppButtonStyle.ghost:
          return TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.primary,
              padding: currentPadding,
              textStyle: textStyle,
              minimumSize: Size(0, exactHeight),
              shape: shape,
            ),
            child: childWidget,
          );
      }
    }

    final activeIconWidget =
        customIcon ?? (icon != null ? Icon(icon, size: iconSize) : null);

    if (label == null && activeIconWidget != null) {
      return SizedBox.square(
        dimension: exactHeight,
        child: buildNativeButton(
          activeIconWidget,
          isIconOnly: true,
        ),
      );
    }

    return buildNativeButton(
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (activeIconWidget != null) ...[
            activeIconWidget,
            const SizedBox(width: AppDimensions.sm),
          ],
          Text(label!),
        ],
      ),
    );
  }
}
