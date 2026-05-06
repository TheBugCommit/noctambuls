enum SkyCondition {
  clear(0),
  partialCloudy(1),
  overcast(2)
  ;

  const SkyCondition(this.value);

  final int value;
}
