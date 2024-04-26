import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future iosDatePicker({
  required BuildContext context,
  required DateTime? selectedDate,
  DateTime? minimumDate,
  DateTime? maximumDate,
  required Function(DateTime) onChange,
  required Function() onCancel,
  required Function() onDone,
  List<DateTime>? activeDates,
  bool showDayOfWeek = false,
}) {
  return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          height: 300.0,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: onCancel,
                    child: const Text(
                      "cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onDone,
                    child: const Text("done",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: CupertinoDatePicker(
                  showDayOfWeek: showDayOfWeek,
                  initialDateTime: selectedDate,
                  minimumDate: minimumDate,
                  maximumDate: maximumDate ?? DateTime(2100),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: onChange,
                ),
              ),
            ],
          ),
        );
      });
}
