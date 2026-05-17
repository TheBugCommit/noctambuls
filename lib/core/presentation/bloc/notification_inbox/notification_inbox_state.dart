part of 'notification_inbox_bloc.dart';

final class NotificationInboxState extends Equatable {
  const NotificationInboxState({required this.notifications});

  final List<InAppNotification> notifications;

  @override
  List<Object?> get props => [notifications];
}
