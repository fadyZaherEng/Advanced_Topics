// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_action_dialog_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission(String file, context) async {
  Permission permission = Permission.storage;
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    permission = androidInfo.version.sdkInt >= 33
        ? Permission.mediaLibrary
        : Permission.storage;
  } else {
    permission = Permission.storage;
  }
  PermissionStatus status = await permission.request();
  if (status.isGranted) {
    _onDownloadQrClicked(file);
  } else {
    bool storagePermission = await PermissionServiceHandler()
        .handleServicePermission(setting: permission);
    if (storagePermission) {
      _onDownloadQrClicked(file);
    } else {
      showActionDialogWidget(
        icon: "",
        primaryAction: () async {
          Navigator.pop(context);
          openAppSettings().then((value) {
            requestStoragePermission(file, context);
          });
        },
        secondaryAction: () {
          Navigator.pop(context);
        },
        primaryText: !context.mounted ? "" : "S.of(context).ok",
        secondaryText: !context.mounted ? "" : "S.of(context).cancel",
        text: !context.mounted
            ? ""
            : " S.of(context).youShouldHaveStoragePermission",
        context: context,
      );
    }
  }
}

void _onDownloadQrClicked(String file) async {
  bool downloadSuccess = true;
  Directory? dir;
  if (Platform.isIOS) {
    dir = await getApplicationDocumentsDirectory();
  } else {
    dir = await DownloadsPathProvider.downloadsDirectory;
  }
  if (dir != null) {
    try {
      await Dio().download(
        file,
        "${dir.path}/${file.split("/").last}",
        onReceiveProgress: (received, total) {},
      );
    } on DioError {
      downloadSuccess = false;
      showToastMessage("failed");
    }
    if (downloadSuccess) {
      showToastMessage("success");
    } else {
      showToastMessage("failed");
    }
  }
}

void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}
