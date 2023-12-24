import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  static const _numericRegex = r'^\d{0,9}(\.\d{0,2})?';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newString =
        RegExp(_numericRegex).stringMatch(newValue.text.replaceAll(',', '')) ??
            '';

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}