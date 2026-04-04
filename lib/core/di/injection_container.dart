import 'package:get_it/get_it.dart';
import 'package:noctambuls/core/di/features/settings_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  initSettingsFeature();
}
