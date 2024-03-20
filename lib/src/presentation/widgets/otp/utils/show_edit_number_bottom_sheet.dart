import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/bottom_sheet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp/widgets/edit_number_bottom_sheet_widget.dart';

Future showEditNumberBottomSheet({
  required BuildContext context,
  required String phoneNumber,
  required int userId,
  required Function(int, String) onEditPhoneNumber,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetWidget(
        titleLabel: "S.of(context).editPhoneNumber",
        height: 300,
        content: EditNumberBottomSheetWidget(
          phoneNumber: phoneNumber,
          userId: userId,
          onEditPhoneNumber: onEditPhoneNumber,
        ),
      ),
    ),
  );
}
