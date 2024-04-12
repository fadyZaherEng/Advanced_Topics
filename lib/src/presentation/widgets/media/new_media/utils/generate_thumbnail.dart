import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';

Future<Uint8List?> generateThumbnail(String videoPath) async {
  final uint8list = await VideoThumbnail.thumbnailData(
    video: videoPath,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128,
    quality: 100,
  );
  return uint8list;
}