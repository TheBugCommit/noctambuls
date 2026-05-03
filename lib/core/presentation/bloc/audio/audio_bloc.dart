import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/usecases/listen_audio_state_usecase.dart';
import 'package:noctambuls/core/domain/usecases/preload_audio_usecase.dart';
import 'package:noctambuls/core/domain/usecases/toggle_audio_usecase.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/presentation/bloc/audio/audio_event.dart';
import 'package:noctambuls/core/presentation/bloc/audio/audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc({
    required this.toggleAudioUseCase,
    required this.listenAudioStateUseCase,
    required this.preloadAudioUseCase,
    required this.logger,
  }) : super(const AudioInitial()) {
    on<ToggleAudioRequested>(_onToggleAudio);
    on<AudioStateChangedInternal>(_onAudioStateChanged);
    on<PreloadAudioRequested>(_onPreloadAudio);

    _audioSubscription = listenAudioStateUseCase().listen((path) {
      add(AudioStateChangedInternal(playingPath: path));
    });
  }

  final ToggleAudioUseCase toggleAudioUseCase;
  final ListenAudioStateUseCase listenAudioStateUseCase;
  final PreloadAudioUseCase preloadAudioUseCase;
  final IAppLogger logger;

  StreamSubscription<String?>? _audioSubscription;

  Future<void> _onToggleAudio(
    ToggleAudioRequested event,
    Emitter<AudioState> emit,
  ) async {
    final result = await toggleAudioUseCase(event.audioPath);

    result.when(
      success: (_) {},
      failure: (failure) {
        emit(
          AudioActionFailure(
            failure: failure,
            currentlyPlayingPath: state.currentlyPlayingPath,
            timestamp: DateTime.now(),
          ),
        );
        logger.failure(failure);
      },
    );
  }

  void _onAudioStateChanged(
    AudioStateChangedInternal event,
    Emitter<AudioState> emit,
  ) {
    if (event.playingPath != null) {
      emit(AudioPlaying(currentlyPlayingPath: event.playingPath!));
    } else {
      emit(const AudioStopped());
    }
  }

  Future<void> _onPreloadAudio(
    PreloadAudioRequested event,
    Emitter<AudioState> emit,
  ) async {
    unawaited(preloadAudioUseCase(event.audioPaths));
  }

  @override
  Future<void> close() async {
    await _audioSubscription?.cancel();
    return super.close();
  }
}
