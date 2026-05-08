import 'package:equatable/equatable.dart';

sealed class PhoneSettingsEvent extends Equatable {
  const PhoneSettingsEvent();

  @override
  List<Object?> get props => [];
}

final class OpenAppSettingsRequested extends PhoneSettingsEvent {
  const OpenAppSettingsRequested();
}

final class OpenLocationSettingsRequested extends PhoneSettingsEvent {
  const OpenLocationSettingsRequested();
}
