import 'package:equatable/equatable.dart';

class NotificationSettingsState extends Equatable {
  const NotificationSettingsState({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object> get props => [isEnabled];
}
