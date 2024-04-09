import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

void androidTimePicker({
  required BuildContext context,
  required TimeOfDay? selectedTime,
  required Function(TimeOfDay?) onSelectTime,
}) async {
  TimeOfDay? chosenTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    const ColorScheme.light(primary: ColorSchemes.primary)),
            child: child!);
      });

  if (chosenTime != null) {
    onSelectTime(chosenTime);
  } else {
    onSelectTime(null);
  }
}
