import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/usecases/listen_audio_state_usecase.dart';
import 'package:noctambuls/core/domain/usecases/open_link_usecase.dart';
import 'package:noctambuls/core/domain/usecases/preload_audio_usecase.dart';
import 'package:noctambuls/core/domain/usecases/toggle_audio_usecase.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/accept_aud_warning_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/check_audio_warning_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_state.dart';

class GuideBloc extends Bloc<GuideEvent, GuideState> {
  GuideBloc({
    required this.getBirdsUseCase,
    required this.logger,
    required this.openLinkUseCase,
    required this.toggleAudioUseCase,
    required this.listenAudioStateUseCase,
    required this.preloadAudioUseCase,
    required this.checkAudioWarningUseCase,
    required this.acceptAudioWarningUseCase,
  }) : super(const GuideInitial()) {
    on<LoadBirds>(_onLoadBirds);
    on<OpenBirdLink>(_onOpenBirdLink);
    on<ToggleBirdAudio>(_onToggleAudio);
    on<AudioStateChanged>(_onAudioStateChanged);
    _audioSubscription = listenAudioStateUseCase().listen((path) {
      add(AudioStateChanged(playingPath: path));
    });
    on<AcceptAudioWarningAndPlay>(_onAcceptAudioWarningAndPlay);
  }

  final GetBirdsUseCase getBirdsUseCase;
  final IAppLogger logger;
  final OpenLinkUseCase openLinkUseCase;
  final ToggleAudioUseCase toggleAudioUseCase;
  final ListenAudioStateUseCase listenAudioStateUseCase;
  final PreloadAudioUseCase preloadAudioUseCase;
  final CheckAudioWarningUseCase checkAudioWarningUseCase;
  final AcceptAudioWarningUseCase acceptAudioWarningUseCase;
  StreamSubscription<String?>? _audioSubscription;

  Future<void> _onLoadBirds(
    LoadBirds event,
    Emitter<GuideState> emit,
  ) async {
    emit(const GuideLoading());
    final result = await getBirdsUseCase(event.languageCode);

    result.when(
      success: (birds) {
        if (birds.isEmpty) {
          emit(const GuideEmptyNeedsSync());
          return;
        }

        final audioPaths = birds
            .map(
              (bird) =>
                  bird.hasLocalAudio ? bird.localAudioPath! : bird.audioUrl,
            )
            .toList();
        unawaited(preloadAudioUseCase(audioPaths));
        emit(GuideLoaded(birds: birds));
      },
      failure: (failure) {
        logger.failure(failure);
        emit(GuideError(failure: failure));
      },
    );
  }

  Future<void> _onOpenBirdLink(
    OpenBirdLink event,
    Emitter<GuideState> emit,
  ) async {
    final result = await openLinkUseCase(event.url);

    result.when(
      success: (_) {},
      failure: (failure) {
        final currentState = state.loaded;
        if (currentState != null) {
          emit(currentState.copyWith(actionError: GuideUrlError()));
        }
        logger.failure(failure);
      },
    );
  }

  Future<void> _onToggleAudio(
    ToggleBirdAudio event,
    Emitter<GuideState> emit,
  ) async {
    if (state is! GuideLoaded) return;
    final warningResult = await checkAudioWarningUseCase();
    final currentState = state as GuideLoaded;

    var hasAccepted = false;
    warningResult.when(
      success: (value) => hasAccepted = value,
      failure: (_) => hasAccepted = false,
    );

    if (!hasAccepted) {
      emit(
        currentState.copyWith(
          action: GuideAudioWarning(audioPath: event.audioPath),
        ),
      );
      return;
    }

    final result = await toggleAudioUseCase(event.audioPath);

    result.when(
      success: (_) {},
      failure: (failure) {
        final currentState = state.loaded;
        if (currentState != null) {
          emit(currentState.copyWith(actionError: GuideAudioError()));
        }
        logger.failure(failure);
      },
    );
  }

  void _onAudioStateChanged(
    AudioStateChanged event,
    Emitter<GuideState> emit,
  ) {
    final currentState = state.loaded;
    if (currentState != null) {
      emit(
        GuideLoaded(
          birds: currentState.birds,
          actionError: currentState.actionError,
          currentlyPlayingPath: event.playingPath,
        ),
      );
    }
  }

  Future<void> _onAcceptAudioWarningAndPlay(
    AcceptAudioWarningAndPlay event,
    Emitter<GuideState> emit,
  ) async {
    final saveResult = await acceptAudioWarningUseCase();
    saveResult.when(
      success: (_) {
        add(ToggleBirdAudio(audioPath: event.audioPath));
      },
      failure: (failure) {
        logger.failure(failure);
      },
    );
  }

  @override
  Future<void> close() async {
    await _audioSubscription?.cancel();
    return super.close();
  }
}
