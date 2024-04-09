// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:permission_handler/permission_handler.dart';

void showBottomSheetMedia(
    BuildContext context, String type, int maxDuration) async {
  showBottomSheetUploadMedia(
    context: context,
    onTapCamera: () async {
      if (await PermissionServiceHandler().handleServicePermission(
        setting: Permission.camera,
      )) {
        Navigator.pop(context);
        // if (type == "image") {
        //   _pickImage(context);
        // } else {
        //   _pickVideo(context, maxDuration);
        // }
      } else if (!await PermissionServiceHandler()
          .handleServicePermission(setting: Permission.camera)) {
        showActionDialogWidget(
          context: context,
          text: "youShouldHaveCameraPermission",
          icon: "ImagePaths.camera",
          primaryText: "ok",
          secondaryText: "cancel",
          primaryAction: () async {
            openAppSettings().then((value) {
              Navigator.pop(context);
              if (value) {
                //implement code;
              }
            });
          },
          secondaryAction: () {
            Navigator.of(context).pop();
          },
        );
      }
    },
    onTapGallery: () async {
      if (await PermissionServiceHandler().handleServicePermission(
        setting: Permission.storage,
      )) {
        Navigator.pop(context);
        // if (type == "image") {
        //   _getImageFromGallery(context);
        // } else {
        //   _getVideoFromGallery(context);
        // }
      } else if (!await PermissionServiceHandler()
          .handleServicePermission(setting: Permission.storage)) {
        showActionDialogWidget(
          context: context,
          text: "S.of(context).youShouldHaveStoragePermission",
          icon: "ImagePaths.gallery",
          primaryText: "S.of(context).ok",
          secondaryText: "S.of(context).cancel",
          primaryAction: () async {
            openAppSettings().then(
              (value) async {
                Navigator.pop(context);
              },
            );
          },
          secondaryAction: () {
            Navigator.of(context).pop();
          },
        );
      }
    },
  );
}
