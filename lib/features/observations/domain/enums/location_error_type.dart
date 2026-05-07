enum LocationErrorType {
  permissionDenied(0),
  gpsDisabled(1),
  timeoutNoSignal(2)
  ;

  const LocationErrorType(this.value);

  final int value;
}
