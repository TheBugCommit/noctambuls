enum ValidationStatus {
  pending(0),
  validated(1),
  rejected(2)
  ;

  const ValidationStatus(this.value);

  final int value;
}
