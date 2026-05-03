import 'package:noctambuls/core/data/services/audio_player_service_impl.dart';
import 'package:noctambuls/core/data/services/external_link_service_impl.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/domain/services/audio_player_service.dart';
import 'package:noctambuls/core/domain/services/external_link_service.dart';
import 'package:noctambuls/core/domain/usecases/listen_audio_state_usecase.dart';
import 'package:noctambuls/core/domain/usecases/open_url_usecase.dart';
import 'package:noctambuls/core/domain/usecases/preload_audio_usecase.dart';
import 'package:noctambuls/core/domain/usecases/toggle_audio_usecase.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';

void initCore() {
  sl
    ..registerLazySingleton<ExternalLinkService>(
      () => ExternalLinkServiceImpl(logger: sl<IAppLogger>()),
    )
    ..registerLazySingleton<AudioPlayerService>(
      () => SoLoudAudioServiceImpl(logger: sl<IAppLogger>()),
      dispose: (service) => service.dispose(),
    )
    ..registerLazySingleton(() => OpenUrlUseCase(sl()))
    ..registerLazySingleton(() => ListenAudioStateUseCase(sl()))
    ..registerLazySingleton(() => ToggleAudioUseCase(sl()))
    ..registerLazySingleton(() => PreloadAudioUseCase(sl()))
    ..registerFactory(
      () => UrlBloc(openUrlUseCase: sl(), logger: sl<IAppLogger>()),
    );
}
