import 'dart:io';

import 'package:flutter_advanced_topics/src/presentation/widgets/media/new_media/utils/compress_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

Future<List<File>> convertAssetEntitiesToFiles(
    List<AssetEntity>? assetEntities) async {
  List<File> files = [];

  if (assetEntities == null) {
    return files;
  }

  for (AssetEntity assetEntity in assetEntities) {
    File? file = await assetEntity.file;
    if (file != null) {
      files.add(file);
      XFile? imageFile = await compressFile(File(file.path));
      files.add(File(imageFile!.path));
    }
  }

  return files;
}
