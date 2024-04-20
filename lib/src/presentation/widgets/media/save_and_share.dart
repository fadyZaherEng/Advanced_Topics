// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_snack_bar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SaveAndShareImage extends StatefulWidget {
  const SaveAndShareImage({super.key});

  @override
  State<SaveAndShareImage> createState() => _SaveAndShareImageState();
}

class _SaveAndShareImageState extends State<SaveAndShareImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save and Share Image'),
      ),
    );
  }

  Future<void> shareFile(String shareLink) async {
    try {
      // Fetch the image bytes from the network
      http.Response response = await http.get(Uri.parse(shareLink));
      if (response.statusCode == 200) {
        await Share.shareUri(Uri.parse(shareLink));
      } else {
        showMassageDialogWidget(
          context: context,
          text: "Failed To Share Image",
          icon: ImagePaths.error,
          buttonText: "Ok",
          onTap: () {
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      showMassageDialogWidget(
        context: context,
        text: "Failed To Share Image",
        icon: ImagePaths.error,
        buttonText: "Ok",
        onTap: () {
          Navigator.pop(context);
        },
      );
      // Handle the error as needed
    }
  }

  Future<void> shareImage(String imageUrl) async {
    try {
      // Fetch the image bytes from the network
      http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List imageBytes = response.bodyBytes;

        // Save the image to a temporary file
        Directory tempDir;
        if (Platform.isIOS) {
          tempDir = await getApplicationDocumentsDirectory();
        } else {
          tempDir = await getTemporaryDirectory();
        }
        File tempFile = File('${tempDir.path}/image.png');
        await tempFile.writeAsBytes(imageBytes);

        // Use the share function to share the image
        await Share.shareXFiles([XFile(tempFile.path)], text: imageUrl);
      } else {
        showMassageDialogWidget(
            context: context,
            text: "S.of(context).failedToShareImage",
            icon: ImagePaths.error,
            buttonText: "S.of(context).ok",
            onTap: () {
              Navigator.pop(context);
            });
      }
    } catch (e) {
      showMassageDialogWidget(
          context: context,
          text: "S.of(context).failedToShareImage",
          icon: ImagePaths.error,
          buttonText: "S.of(context).ok",
          onTap: () {
            Navigator.pop(context);
          });
      // Handle the error as needed
    }
  }

  void _onDownloadQrClicked(String file) async {
    bool downloadSuccess = true;
    Directory? dir;
    CustomSnackBarWidget.show(
      context: context,
      message: "S.of(context).downloading",
      backgroundColor: ColorSchemes.gray,
      path: ImagePaths.info,
    );

    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = await DownloadsPathProvider.downloadsDirectory;
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
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        CustomSnackBarWidget.show(
          context: context,
          message: "S.current.failedToDownloadTheQrCodePleaseTryAgain",
          backgroundColor: ColorSchemes.gray,
          path: ImagePaths.error,
        );
      }
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (downloadSuccess) {
        CustomSnackBarWidget.show(
          context: context,
          message: "S.current.success",
          backgroundColor: ColorSchemes.gray,
          path: ImagePaths.success,
        );
      } else {
        CustomSnackBarWidget.show(
          context: context,
          message: "S.current.failedToDownloadTheQrCodePleaseTryAgain",
          backgroundColor: ColorSchemes.gray,
          path: ImagePaths.error,
        );
      }
    }
  }
}
