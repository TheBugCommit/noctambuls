import 'package:get_it/get_it.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/di/features/auth_injection.dart';
import 'package:noctambuls/core/di/features/observations_injection.dart';
import 'package:noctambuls/core/di/features/settings_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AppDatabase>(AppDatabase.new);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  initAuthFeature();
  initSettingsFeature();
  initObservationsFeature();
}
