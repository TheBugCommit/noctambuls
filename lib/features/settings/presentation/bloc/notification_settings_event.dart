import 'package:equatable/equatable.dart';

sealed class NotificationSettingsEvent extends Equatable {
  const NotificationSettingsEvent();

  @override
  List<Object?> get props => [];
}

final class ToggleNotificationsRequested extends NotificationSettingsEvent {
  const ToggleNotificationsRequested({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

final class NotificationPermissionCheckRequested
    extends NotificationSettingsEvent {
  const NotificationPermissionCheckRequested();
}
