import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';
import 'package:noctambuls/features/settings/domain/usecases/get_language_usecase.dart';
import 'package:noctambuls/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({
    required this.getLanguageUseCase,
    required this.saveLanguageUseCase,
  }) : super(LanguageState(appLanguage: getLanguageUseCase()));
  final GetLanguageUseCase getLanguageUseCase;
  final SaveLanguageUseCase saveLanguageUseCase;

  Future<void> changeLanguage(AppLanguage newLanguage) async {
    emit(LanguageState(appLanguage: newLanguage));
    await saveLanguageUseCase(newLanguage);
  }
}
