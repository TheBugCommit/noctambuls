enum LocationSource {
  gps(0),
  manual(1)
  ;

  const LocationSource(this.value);

  final int value;
}
