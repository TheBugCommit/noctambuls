import 'package:noctambuls/core/data/services/audio_player_service_impl.dart';
import 'package:noctambuls/core/data/services/external_link_service_impl.dart';
import 'package:noctambuls/core/data/services/share_service_impl.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/domain/services/audio_player_service.dart';
import 'package:noctambuls/core/domain/services/external_link_service.dart';
import 'package:noctambuls/core/domain/services/share_service.dart';
import 'package:noctambuls/core/domain/usecases/audio/listen_audio_state_usecase.dart';
import 'package:noctambuls/core/domain/usecases/audio/preload_audio_usecase.dart';
import 'package:noctambuls/core/domain/usecases/audio/toggle_audio_usecase.dart';
import 'package:noctambuls/core/domain/usecases/share/share_text_usecase.dart';
import 'package:noctambuls/core/domain/usecases/share/share_uri_usecase.dart';
import 'package:noctambuls/core/domain/usecases/url/open_url_usecase.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/presentation/bloc/audio/audio_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/share/share_bloc.dart';
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
    ..registerLazySingleton<ShareService>(ShareServiceImpl.new)
    ..registerLazySingleton(() => ShareTextUseCase(shareService: sl()))
    ..registerLazySingleton(() => ShareUriUseCase(shareService: sl()))
    ..registerLazySingleton(() => OpenUrlUseCase(sl()))
    ..registerLazySingleton(() => ListenAudioStateUseCase(sl()))
    ..registerLazySingleton(() => ToggleAudioUseCase(sl()))
    ..registerLazySingleton(() => PreloadAudioUseCase(sl()))
    ..registerFactory(
      () => UrlBloc(openUrlUseCase: sl(), logger: sl<IAppLogger>()),
    )
    ..registerFactory(
      () => AudioBloc(
        preloadAudioUseCase: sl(),
        listenAudioStateUseCase: sl(),
        toggleAudioUseCase: sl(),
        logger: sl<IAppLogger>(),
      ),
    )
    ..registerFactory(
      () => ShareBloc(shareTextUseCase: sl(), shareUriUseCase: sl()),
    );
}
