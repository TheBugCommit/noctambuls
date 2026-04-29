import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/services/audio_service.dart';
import 'package:noctambuls/core/services/external_service_link.dart';
import 'package:noctambuls/core/services/external_service_link_impl.dart';
import 'package:noctambuls/core/services/soloud_audio_service.dart';

void initServices() {
  sl
    ..registerLazySingleton<ExternalLinkService>(
      () => ExternalLinkServiceImpl(logger: sl<IAppLogger>()),
    )
    ..registerLazySingleton<AudioService>(
      () => SoLoudAudioService(logger: sl<IAppLogger>()),
    );
}
