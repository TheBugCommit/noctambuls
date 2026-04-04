import 'dart:ui';

abstract class ThemeSystemDataSource {
  bool isSystemDarkMode();
}

class ThemeSystemDataSourceImpl implements ThemeSystemDataSource {
  @override
  bool isSystemDarkMode() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    return brightness == Brightness.dark;
  }
}
