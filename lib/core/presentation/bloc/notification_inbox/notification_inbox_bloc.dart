import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/entities/in_app_notification.dart';
import 'package:noctambuls/core/domain/repositories/in_app_notification_repository.dart';

part 'notification_inbox_event.dart';
part 'notification_inbox_state.dart';

class NotificationInboxBloc
    extends Bloc<NotificationInboxEvent, NotificationInboxState> {
  NotificationInboxBloc({required InAppNotificationRepository repository})
    : _repository = repository,
      super(const NotificationInboxState(notifications: [])) {
    on<NotificationInboxStarted>(_onStarted);
    on<NotificationInboxDeleted>(_onDeleted);
    on<NotificationInboxCleared>(_onCleared);
    on<NotificationInboxRefreshed>(_onRefreshed);
    on<NotificationInboxUpdated>(_onUpdated);
  }

  final InAppNotificationRepository _repository;
  StreamSubscription<List<InAppNotification>>? _subscription;

  Future<void> _onStarted(
    NotificationInboxStarted event,
    Emitter<NotificationInboxState> emit,
  ) async {
    await _subscription?.cancel();

    _subscription = _repository.watchAll().listen(
      (notifications) => add(NotificationInboxUpdated(notifications)),
    );
  }

  Future<void> _onDeleted(
    NotificationInboxDeleted event,
    Emitter<NotificationInboxState> emit,
  ) async {
    await _repository.delete(event.id);
  }

  Future<void> _onCleared(
    NotificationInboxCleared event,
    Emitter<NotificationInboxState> emit,
  ) async {
    await _repository.clear();
  }

  Future<void> _onRefreshed(
    NotificationInboxRefreshed event,
    Emitter<NotificationInboxState> emit,
  ) async {
    await _subscription?.cancel();
    _subscription = _repository.watchAll().listen(
      (notifications) => add(NotificationInboxUpdated(notifications)),
    );
  }

  void _onUpdated(
    NotificationInboxUpdated event,
    Emitter<NotificationInboxState> emit,
  ) {
    emit(NotificationInboxState(notifications: event.notifications));
  }

  @override
  Future<void> close() {
    unawaited(_subscription?.cancel());
    return super.close();
  }
}
