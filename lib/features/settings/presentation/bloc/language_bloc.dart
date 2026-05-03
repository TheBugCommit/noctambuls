import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_event.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc({
    required this.getLanguageUseCase,
    required this.saveLanguageUseCase,
    required this.logger,
  }) : super(LanguageState(appLanguage: getLanguageUseCase())) {
    on<ChangeLanguageRequested>(_onChangeLanguage);
  }

  final GetLanguageUseCase getLanguageUseCase;
  final SaveLanguageUseCase saveLanguageUseCase;
  final IAppLogger logger;

  Future<void> _onChangeLanguage(
    ChangeLanguageRequested event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageState(appLanguage: event.language));
    final result = await saveLanguageUseCase(event.language);
    result.when(
      success: (_) {},
      failure: logger.failure,
    );
  }
}
