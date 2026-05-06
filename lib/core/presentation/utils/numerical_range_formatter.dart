import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  NumericalRangeFormatter({required this.min, required this.max});

  final double min;
  final double max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '' || newValue.text == '-') {
      return newValue;
    }

    final normalizedValue = newValue.text.replaceAll(',', '.');
    final value = double.tryParse(normalizedValue);

    if (value == null) {
      return oldValue;
    }

    if (value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}
