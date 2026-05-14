enum SyncErrorType {
  network(0),
  validation(1),
  server(2),
  unknown(3)
  ;

  const SyncErrorType(this.value);

  final int value;
}
