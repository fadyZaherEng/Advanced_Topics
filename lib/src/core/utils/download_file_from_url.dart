import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_massage_dialog_widget.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

String Progress = "0%";

void _downloadFile(String url, String filename, context) async {
  if (await PermissionServiceHandler()
      .handleServicePermission(setting: Permission.storage)) {
    showMessageDialogWidget(
      context: context,
      text: Progress,
      icon: ImagePaths.imagesIcLogo,
      buttonText: "Waiting....",
      onTap: () {},
    );
    FileDownloader.downloadFile(
        url: url,
        name: filename,
        onProgress: (String? fileName, double progress) {
          // setState(() {
          //   Progress = "${progress * 100}%";
          // });
          print('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
          Navigator.of(context).pop();
          print('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
          Navigator.of(context).pop();
        });
  } else {
    showActionDialogWidget(
      context: context,
      text: "youShouldHaveCameraPermission",
      icon: ImagePaths.imagesIcLogo,
      primaryText: "Open Settings",
      secondaryText: "cancel",
      primaryAction: () async {
        Navigator.of(context).pop();
        openAppSettings().then((value) async {
          if (value) {
            FileDownloader.downloadFile(
                url: url,
                name: filename,
                onProgress: (String? fileName, double progress) {
                  // setState(() {
                  //   Progress = "${progress * 100}%";
                  // });
                  print('FILE fileName HAS PROGRESS $progress');
                },
                onDownloadCompleted: (String path) {
                  Navigator.of(context).pop();
                  print('FILE DOWNLOADED TO PATH: $path');
                },
                onDownloadError: (String error) {
                  print('DOWNLOAD ERROR: $error');
                  Navigator.of(context).pop();
                });
          }
        });
      },
      secondaryAction: () {
        Navigator.of(context).pop();
      },
    );
  }
}
