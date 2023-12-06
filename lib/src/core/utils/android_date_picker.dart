import 'package:flutter/material.dart';

void androidDatePicker({
  required BuildContext context,
  required DateTime? selectedDate,
  required Function(DateTime?) onSelectDate,
}) async {
  var chosenDateTime = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now() ,
    firstDate: DateTime(DateTime.now().year , DateTime.now().month, DateTime.now().day),
    lastDate: DateTime(2100),
  );

  if (chosenDateTime != null) {
    onSelectDate(chosenDateTime);
  } else {
    onSelectDate(null);
  }
}
