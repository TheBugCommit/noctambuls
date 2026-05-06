enum RainLevel {
  none(0),
  drizzle(1),
  storm(2)
  ;

  const RainLevel(this.value);

  final int value;
}
