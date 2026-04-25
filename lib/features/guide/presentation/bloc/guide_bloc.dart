import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/services/audio_service.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_state.dart';

class GuideBloc extends Bloc<GuideEvent, GuideState> {
  GuideBloc({required this.getBirdsUseCase, required this.audioService})
    : super(const GuideInitial()) {
    on<LoadBirds>(_onLoadBirds);
  }

  final GetBirdsUseCase getBirdsUseCase;
  final AudioService audioService;

  Future<void> _onLoadBirds(
    LoadBirds event,
    Emitter<GuideState> emit,
  ) async {
    emit(const GuideLoading());
    final result = await getBirdsUseCase(event.languageCode);

    result.when(
      success: (birds) {
        final audioPaths = birds.map((bird) => bird.audioPath).toList();
        unawaited(audioService.preload(audioPaths));
        emit(GuideLoaded(birds: birds));
      },
      failure: (failure) {
        AppLogger.failure(failure);
        emit(GuideError(failure: failure));
      },
    );
  }

  @override
  Future<void> close() async {
    await audioService.dispose();
    return super.close();
  }
}
