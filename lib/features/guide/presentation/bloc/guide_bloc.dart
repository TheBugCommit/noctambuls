import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
    required this.checkAudioWarningUseCase,
    required this.acceptAudioWarningUseCase,
  }) : super(const GuideInitial()) {
    on<LoadBirds>(_onLoadBirds);
    on<CheckBirdAudioWarningRequested>(_onCheckAudioWarning);
    on<AcceptAudioWarning>(_onAcceptAudioWarning);
  }

  final GetBirdsUseCase getBirdsUseCase;
  final IAppLogger logger;
  final CheckAudioWarningUseCase checkAudioWarningUseCase;
  final AcceptAudioWarningUseCase acceptAudioWarningUseCase;

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
        emit(GuideLoaded(birds: birds));
      },
      failure: (failure) {
        logger.failure(failure);
        emit(GuideError(failure: failure));
      },
    );
  }

  Future<void> _onCheckAudioWarning(
    CheckBirdAudioWarningRequested event,
    Emitter<GuideState> emit,
  ) async {
    if (state is! GuideLoaded) return;
    final currentState = state as GuideLoaded;

    final warningResult = await checkAudioWarningUseCase();
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
    } else {
      emit(
        currentState.copyWith(
          action: GuideAudioPlayApproved(audioPath: event.audioPath),
        ),
      );
    }
  }

  Future<void> _onAcceptAudioWarning(
    AcceptAudioWarning event,
    Emitter<GuideState> emit,
  ) async {
    if (state is! GuideLoaded) return;
    final currentState = state as GuideLoaded;

    final saveResult = await acceptAudioWarningUseCase();

    saveResult.when(
      success: (_) {
        emit(
          currentState.copyWith(
            action: GuideAudioPlayApproved(audioPath: event.audioPath),
          ),
        );
      },
      failure: (failure) {
        logger.failure(failure);
      },
    );
  }
}
