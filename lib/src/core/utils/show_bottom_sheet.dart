import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/bottom_sheet_widget.dart';

Future showBottomSheetWidget({
  required BuildContext context,
  required Widget content,
  required String titleLabel,
  bool isClosed = false,
  double height = 300,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetWidget(
        height: height,
        isClosed: isClosed,
        content: content,
        titleLabel: titleLabel,
      ),
    ),
  );
}
