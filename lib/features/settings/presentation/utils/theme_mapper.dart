import 'package:flutter/material.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';

extension AppThemeMapper on AppTheme {
  ThemeMode get toFlutterThemeMode {
    switch (this) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
      case AppTheme.system:
        return ThemeMode.system;
    }
  }
}
