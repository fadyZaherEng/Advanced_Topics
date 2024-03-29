import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mandatory_update/update_version/utils/launch_store.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mandatory_update/update_version/widget/custom_update_dialog_widget.dart';

Future showUpdateDialog({
  required BuildContext context,
  required bool isMandatory,
}) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: CustomUpdateDialogWidget(
          isMandatory: isMandatory,
          onTapUpdate: () async {
            launchStore();
          },
          onTapSkip: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    ),
  );
}
