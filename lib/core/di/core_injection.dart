import 'package:noctambuls/core/data/services/external_link_service_impl.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/domain/services/ExternalLinkService.dart';
import 'package:noctambuls/core/domain/usecases/open_link_usecase.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/services/audio_service.dart';
import 'package:noctambuls/core/services/soloud_audio_service.dart';

void initCore() {
  sl
    ..registerLazySingleton<ExternalLinkService>(
      () => ExternalLinkServiceImpl(logger: sl<IAppLogger>()),
    )
    ..registerLazySingleton<AudioService>(
      () => SoLoudAudioService(logger: sl<IAppLogger>()),
    )
    ..registerLazySingleton(() => OpenLinkUseCase(sl()));
}
