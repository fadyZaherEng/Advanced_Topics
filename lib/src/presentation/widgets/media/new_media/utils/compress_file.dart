import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<XFile?> compressFile(File file) async {
  final filePath = file.absolute.path;
  final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

  if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
        format: CompressFormat.png);
    return compressedImage;
  } else {
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      minWidth: 1000,
      minHeight: 1000,
      quality: 50,
    );
    return compressedImage;
  }
}
