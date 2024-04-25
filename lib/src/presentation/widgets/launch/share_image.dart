import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/show_massage_dialog_widget.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareImage(String imageUrl, String shareLink, context) async {
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
      await Share.shareXFiles([XFile(tempFile.path)], text: shareLink);
    } else {
      showMassageDialogWidget(
          context: context,
          text: "failedToShareImage",
          icon: ImagePaths.error,
          buttonText: "ok",
          onTap: () {
            Navigator.pop(context);
          });
    }
  } catch (e) {
    showMassageDialogWidget(
        context: context,
        text: "failedToShareImage",
        icon: ImagePaths.error,
        buttonText: "ok",
        onTap: () {
          Navigator.pop(context);
        });
    // Handle the error as needed
  }
}
