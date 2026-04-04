import 'package:equatable/equatable.dart';

import 'package:noctambuls/features/settings/domain/entities/app_language.dart';

class LanguageState extends Equatable {
  const LanguageState({required this.appLanguage});
  final AppLanguage appLanguage;

  @override
  List<Object> get props => [appLanguage];
}
