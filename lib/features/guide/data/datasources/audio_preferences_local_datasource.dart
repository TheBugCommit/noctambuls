import 'package:shared_preferences/shared_preferences.dart';

abstract class AudioPreferencesLocalDataSource {
  Future<bool> hasAcceptedWarning();

  Future<void> setWarningAccepted();
}

class AudioPreferencesLocalDataSourceImpl
    implements AudioPreferencesLocalDataSource {
  const AudioPreferencesLocalDataSourceImpl({required this.prefs});

  final SharedPreferences prefs;
  static const _key = 'audio_warning_accepted';

  @override
  Future<bool> hasAcceptedWarning() async {
    return prefs.getBool(_key) ?? false;
  }

  @override
  Future<void> setWarningAccepted() async {
    final success = await prefs.setBool(_key, true);
    if (!success) {
      throw Exception('Failed to save audio warning preference');
    }
  }
}
