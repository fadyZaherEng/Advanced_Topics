import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future iosTimePicker({
  required BuildContext context,
  required TimeOfDay? selectedTime,
  required Function(TimeOfDay) onChange,
  required Function() onCancel,
  required Function() onDone,
}) =>
    showCupertinoModalPopup(
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
                    child: const Text(
                      "done",
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
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.time, // Use time mode
                  onDateTimeChanged: (dateTime) {
                    final timeOfDay = TimeOfDay.fromDateTime(dateTime);
                    onChange(timeOfDay);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
