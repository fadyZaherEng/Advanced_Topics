import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:intl/intl.dart';

void androidDatePicker({
  required BuildContext context,
  required DateTime? selectedDate,
  required DateTime firstDate,
  DateTime? lastDate,
  required Function(DateTime?) onSelectDate,
  String helpText = "",
  List<DateTime>? activeDates,
  List<WeekDay> restrictedDays = const [],
}) async {
  var chosenDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? firstDate,
      firstDate: firstDate,
      helpText: helpText == "" ? "selectDate" : helpText,
      lastDate: lastDate ?? DateTime(2100),
      selectableDayPredicate: activeDates == null
          ? null
          : (date) {
              if (date == firstDate) {
                return true;
              }

              for (var i = 0; i < activeDates.length; i++) {
                if (date ==
                    DateTime(activeDates[i].year, activeDates[i].month,
                        activeDates[i].day)) {
                  return false;
                }
              }

              return isRestrictedDays(restrictedDays, date);
            },
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: ColorSchemes.primary)),
            child: child!);
      });

  if (chosenDateTime != null) {
    onSelectDate(chosenDateTime);
  } else {
    onSelectDate(null);
  }
}

class WeekDay {
  final String name;
  const WeekDay({required this.name});
}

bool isRestrictedDays(List<WeekDay> restrictedDays, DateTime date) {
  bool isShowDate = true;

  String day =
      DateFormat('EEEE').format(date).replaceAll("أ", "ا").replaceAll("ة", "ه");

  for (int i = 0; i < restrictedDays.length; i++) {
    if (restrictedDays[i].name.contains(day)) {
      isShowDate = false;
      break;
    }
  }

  return isShowDate;
}
