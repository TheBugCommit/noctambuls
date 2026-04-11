import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

enum AppButtonStyle { primary, secondary, tertiary, destructive, ghost }

enum AppButtonSize { sm, md, lg, xl }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    this.label,
    this.icon,
    this.style = AppButtonStyle.primary,
    this.size = AppButtonSize.md,
    super.key,
  }) : assert(
         label != null || icon != null,
         'Either label or icon must be provided',
       );

  factory AppButton.primary({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    AppButtonSize size = AppButtonSize.md,
  }) => AppButton(
    onPressed: onPressed,
    label: label,
    icon: icon,
    style: AppButtonStyle.primary,
    size: size,
  );

  factory AppButton.secondary({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    AppButtonSize size = AppButtonSize.md,
  }) => AppButton(
    onPressed: onPressed,
    label: label,
    icon: icon,
    style: AppButtonStyle.secondary,
    size: size,
  );

  factory AppButton.destructive({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    AppButtonSize size = AppButtonSize.md,
  }) => AppButton(
    onPressed: onPressed,
    label: label,
    icon: icon,
    style: AppButtonStyle.destructive,
    size: size,
  );

  final VoidCallback? onPressed;
  final String? label;
  final IconData? icon;
  final AppButtonStyle style;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (bgColor, fgColor) = switch (style) {
      AppButtonStyle.primary => (colorScheme.primary, colorScheme.onPrimary),
      AppButtonStyle.secondary => (
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
      ),
      AppButtonStyle.tertiary => (
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
      ),
      AppButtonStyle.destructive => (
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
      ),
      AppButtonStyle.ghost => (Colors.transparent, colorScheme.primary),
    };

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

    final baseStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all(bgColor),
      foregroundColor: WidgetStateProperty.all(fgColor),
      textStyle: WidgetStateProperty.all(textStyle),
      padding: WidgetStateProperty.all(padding),
      minimumSize: WidgetStateProperty.all(Size(0, exactHeight)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
      ),
      elevation: WidgetStateProperty.all(0),
    );

    if (label == null && icon != null) {
      return SizedBox.square(
        dimension: exactHeight,
        child: IconButton(
          onPressed: onPressed,
          style: baseStyle.copyWith(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
          ),
          icon: Icon(icon, size: iconSize),
        ),
      );
    }

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: iconSize),
          const SizedBox(width: AppDimensions.sm),
        ],
        Text(label!),
      ],
    );

    if (style == AppButtonStyle.ghost) {
      return TextButton(onPressed: onPressed, style: baseStyle, child: child);
    }
    return FilledButton(onPressed: onPressed, style: baseStyle, child: child);
  }
}
