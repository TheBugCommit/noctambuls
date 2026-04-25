import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/services/audio_service.dart';
import 'package:noctambuls/core/services/external_service_link.dart';
import 'package:noctambuls/core/services/external_service_link_impl.dart';
import 'package:noctambuls/core/services/soloud_audio_service.dart';

void initServices() {
  sl
    ..registerLazySingleton<ExternalLinkService>(ExternalLinkServiceImpl.new)
    ..registerLazySingleton<AudioService>(SoLoudAudioService.new);
}
