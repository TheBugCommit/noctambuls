enum SessionType {
  incidental(0),
  census(1),
  station(2)
  ;

  const SessionType(this.value);

  final int value;
}
