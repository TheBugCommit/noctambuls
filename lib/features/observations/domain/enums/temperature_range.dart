enum TemperatureRange {
  belowZero(0),
  zeroToTen(1),
  tenToTwenty(2),
  twentyToThirty(3),
  aboveThirty(4);

  const TemperatureRange(this.value);

  final int value;
}
