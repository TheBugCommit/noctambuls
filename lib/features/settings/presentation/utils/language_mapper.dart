import 'package:flutter/material.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';

extension AppLanguageMapper on AppLanguage {
  Locale? get toFlutterLocale {
    switch (this) {
      case AppLanguage.catalan:
        return const Locale('ca');
      case AppLanguage.spanish:
        return const Locale('es');
      case AppLanguage.system:
        return null;
    }
  }
}
