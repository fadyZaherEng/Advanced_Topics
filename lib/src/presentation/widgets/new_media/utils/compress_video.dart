import 'dart:io';

import 'package:video_compress/video_compress.dart';

Future<File?> compressVideo(String path) async {
  MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    path,
    quality: VideoQuality.LowQuality,
    deleteOrigin: false,

  );

  return mediaInfo?.file;
}
