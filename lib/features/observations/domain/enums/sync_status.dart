enum SyncStatus {
  draft(0),
  pending(1),
  syncing(4),
  synced(2),
  error(3)
  ;

  const SyncStatus(this.value);

  final int value;
}
