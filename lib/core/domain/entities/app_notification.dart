sealed class AppNotification {
  const AppNotification();
}

class SyncPendingNotification extends AppNotification {
  const SyncPendingNotification(this.pendingCount);

  final int pendingCount;
}

class SyncErrorNotification extends AppNotification {
  const SyncErrorNotification();
}
