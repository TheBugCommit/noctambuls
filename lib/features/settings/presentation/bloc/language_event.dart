import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

final class ChangeLanguageRequested extends LanguageEvent {
  const ChangeLanguageRequested(this.language);

  final AppLanguage language;

  @override
  List<Object?> get props => [language];
}
