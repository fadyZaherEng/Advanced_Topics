import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/add_payment_bottom_sheet.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/show_bottom_sheet_widget.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TextButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          child: const Text("Show bottom Sheet"),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    bool isCanClose = true;
    showBottomSheetWidget(
      context: context,
      height: MediaQuery.of(context).size.height * 0.7,
      isDismissible: false,
      isPadding: false,
      content: AddPaymentBottomSheet(
        id: 1,//widget.requestId,
        onClose: (bool isClose) {
          isCanClose = isClose;
        },
      ),
      titleLabel: "",
      onClose: () {
        if (isCanClose) {
          Navigator.pop(context);
        } else {
          showActionDialogWidget(
            context: context,
            text: "allChangesWillBeLostIfYouLeaveThisPage",
            icon: ImagePaths.warning,
            primaryAction: () {
              Navigator.pop(context);
            },
            secondaryAction: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            primaryText: "keep",
            secondaryText: "discard",
          );
        }
      },
    );
  }
}
