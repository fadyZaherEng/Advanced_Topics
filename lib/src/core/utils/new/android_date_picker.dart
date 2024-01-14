import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

void androidDatePicker({
  required BuildContext context,
  required DateTime? selectedDate,
  required DateTime firstDate,
  required Function(DateTime?) onSelectDate,
}) async {
  var chosenDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    const ColorScheme.light(primary: ColorSchemes.primary)),
            child: child!);
      });

  if (chosenDateTime != null) {
    onSelectDate(chosenDateTime);
  } else {
    onSelectDate(null);
  }
}
