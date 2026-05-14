import 'package:noctambuls/core/background/sync_pending_sessions_worker.dart';
import 'package:workmanager/workmanager.dart';

Future<void> init() async {
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    syncPeriodicTaskId,
    syncPendingTaskName,
    frequency: const Duration(hours: 6),
    constraints: Constraints(networkType: NetworkType.connected),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
  );
}
