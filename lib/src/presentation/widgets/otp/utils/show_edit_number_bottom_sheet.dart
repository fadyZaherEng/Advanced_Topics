import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/language_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/screens/otp/widgets/edit_number_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future showEditNumberBottomSheet({
  required BuildContext context,
  required String phoneNumber,
  required int userId,
  required Function(int,String) onEditPhoneNumber,
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
        titleLabel: S.of(context).editPhoneNumber,
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
