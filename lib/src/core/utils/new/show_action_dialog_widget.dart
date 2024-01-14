import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/action_dialog_widget.dart';

Future showActionDialogWidget({
  required BuildContext context,
  required String text,
  required String icon,
  required String primaryText,
  required String secondaryText,
  required Function() primaryAction,
  required Function() secondaryAction,
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
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ActionDialogWidget(
              text: text,
              icon: icon,
              primaryText: primaryText,
              secondaryText: secondaryText,
              primaryAction: () => primaryAction(),
              secondaryAction: () => secondaryAction(),
            ),
          )));
}
