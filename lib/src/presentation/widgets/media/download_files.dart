import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class Attachment extends Equatable {
  final String? id;
  final String? name;
  final String? url;
  final String? mediaExtension;

  const Attachment({
    this.id = "",
    this.name = "",
    this.url = "",
    this.mediaExtension = "",
  });

  @override
  List<Object?> get props => [
        id,
        name,
        url,
        mediaExtension,
      ];
}

void downloadAttachments(List<Attachment> attachments) async {
  bool downloadSuccess = true;
  Directory? dir;
  if (Platform.isIOS) {
    dir = await getApplicationDocumentsDirectory();
  } else {
    // dir = await DownloadsPathProvider.downloadsDirectory;
  }
  if (dir != null) {
    for (var attachment in attachments) {
      try {
        await Dio().download(
          attachment.url ?? "",
          "${dir.path}/${attachment.name ?? ""}",
          onReceiveProgress: (received, total) {},
        );
      } on DioError catch (e) {
        downloadSuccess = false;
        showToastMessage("${e.message.toString()}");
      }
    }
    if (downloadSuccess) {
      showToastMessage("S.current.downloadSuccess");
    } else {
      showToastMessage("Something went wrong");
    }
  }
}

void downloadFile(String file) async {
  bool downloadSuccess = true;
  Directory? dir;
  if (Platform.isIOS) {
    dir = await getApplicationDocumentsDirectory();
  } else {
    // dir = await DownloadsPathProvider.downloadsDirectory;
  }
  if (dir != null) {
    try {
      await Dio().download(
        file,
        "${dir.path}/${file.split("/").last ?? ""}",
        onReceiveProgress: (received, total) {},
      );
    } on DioError catch (e) {
      downloadSuccess = false;
      showToastMessage("${e.message.toString()}");
    }
    if (downloadSuccess) {
      showToastMessage("downloadSuccess");
    } else {
      showToastMessage("Something went wrong");
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
