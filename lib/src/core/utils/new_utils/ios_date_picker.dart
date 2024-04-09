import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future iosDatePicker({
  required BuildContext context,
  required DateTime? selectedDate,
  required Function(DateTime) onChange,
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
                        "Cancel",
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
                        "Done",
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
                    initialDateTime: selectedDate ?? DateTime.now(),
                    minimumYear: DateTime.now().year,
                    maximumYear: 2100,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: onChange,
                  ),
                ),
              ],
            ),
          );
        });
