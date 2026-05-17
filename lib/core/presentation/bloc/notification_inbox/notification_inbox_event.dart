part of 'notification_inbox_bloc.dart';

sealed class NotificationInboxEvent extends Equatable {
  const NotificationInboxEvent();

  @override
  List<Object> get props => [];
}

final class NotificationInboxStarted extends NotificationInboxEvent {
  const NotificationInboxStarted();
}

final class NotificationInboxDeleted extends NotificationInboxEvent {
  const NotificationInboxDeleted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class NotificationInboxCleared extends NotificationInboxEvent {
  const NotificationInboxCleared();
}

final class NotificationInboxRefreshed extends NotificationInboxEvent {
  const NotificationInboxRefreshed();
}

class NotificationInboxUpdated extends NotificationInboxEvent {
  const NotificationInboxUpdated(this.notifications);

  final List<InAppNotification> notifications;

  @override
  List<Object> get props => [notifications];
}
