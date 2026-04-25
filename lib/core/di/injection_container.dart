import 'package:get_it/get_it.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/di/features/auth_injection.dart';
import 'package:noctambuls/core/di/features/observations_injection.dart';
import 'package:noctambuls/core/di/features/settings_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<UserDatabaseManager>(UserDatabaseManager.new);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  initAuthFeature();
  initSettingsFeature();
  initObservationsFeature();
}
