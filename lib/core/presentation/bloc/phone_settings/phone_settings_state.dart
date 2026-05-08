import 'package:equatable/equatable.dart';

sealed class PhoneSettingsState extends Equatable {
  const PhoneSettingsState();

  @override
  List<Object?> get props => [];
}

final class PhoneSettingsInitial extends PhoneSettingsState {
  const PhoneSettingsInitial();
}

final class PhoneSettingsActionSuccess extends PhoneSettingsState {
  const PhoneSettingsActionSuccess();
}

final class PhoneSettingsActionFailure extends PhoneSettingsState {
  const PhoneSettingsActionFailure();
}
