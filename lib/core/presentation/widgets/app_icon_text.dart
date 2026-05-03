import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';

class AppIconText extends StatelessWidget {
  const AppIconText({
    required this.icon,
    required this.text,
    this.style,
    this.iconSize = AppDimensions.iconSm,
    this.color,
    super.key,
  });

  final IconData icon;
  final String text;
  final TextStyle? style;
  final double iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveColor = color ?? theme.colorScheme.onSurfaceVariant;
    final effectiveStyle =
        style ??
        theme.textTheme.labelMedium?.copyWith(
          color: effectiveColor,
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: effectiveColor,
        ),
        const SizedBox(width: AppDimensions.xs),
        Flexible(
          child: Text(
            text,
            style: effectiveStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
