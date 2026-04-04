import 'package:flutter/material.dart';
import 'package:noctambuls/core/theme/app_fonts.dart';

TextTheme createTextTheme(BuildContext context) {
  final baseTextTheme = Theme.of(context).textTheme;
  final bodyTextTheme = baseTextTheme.apply(fontFamily: AppFonts.body);
  final displayTextTheme = baseTextTheme.apply(fontFamily: AppFonts.display);
  final textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
