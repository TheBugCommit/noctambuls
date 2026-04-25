import 'dart:ui';

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

  String get toLanguageCode {
    if (this == AppLanguage.system) {
      final deviceLocale = PlatformDispatcher.instance.locale.languageCode;
      return const ['ca', 'es'].contains(deviceLocale) ? deviceLocale : 'ca';
    }
    return toFlutterLocale!.languageCode;
  }
}
