import 'package:get_it/get_it.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/core/di/core_injection.dart';
import 'package:noctambuls/core/di/features/auth_injection.dart';
import 'package:noctambuls/core/di/features/guide_injection.dart';
import 'package:noctambuls/core/di/features/observations_injection.dart';
import 'package:noctambuls/core/di/features/profile_injection.dart';
import 'package:noctambuls/core/di/features/settings_injection.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton<IAppLogger>(() => AppLogger.instance)
    ..registerLazySingleton<AppDatabase>(AppDatabase.new)
    ..registerLazySingleton<UserDatabaseManager>(
      () => UserDatabaseManager(sl<IAppLogger>()),
    );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  initCore();
  initAuthFeature();
  initSettingsFeature();
  initObservationsFeature();
  initGuideFeature();
  initProfileFeature();
}
