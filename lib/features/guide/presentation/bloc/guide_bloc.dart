import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_state.dart';

class GuideBloc extends Bloc<GuideEvent, GuideState> {
  GuideBloc({required this.getBirdsUseCase}) : super(const GuideInitial()) {
    on<LoadBirds>(_onLoadBirds);
  }

  final GetBirdsUseCase getBirdsUseCase;

  Future<void> _onLoadBirds(
    LoadBirds event,
    Emitter<GuideState> emit,
  ) async {
    emit(const GuideLoading());
    final result = await getBirdsUseCase(event.languageCode);
    result.when(
      success: (birds) => emit(GuideLoaded(birds: birds)),
      failure: (failure) {
        AppLogger.failure(failure);
        emit(GuideError(failure: failure));
      },
    );
  }
}
