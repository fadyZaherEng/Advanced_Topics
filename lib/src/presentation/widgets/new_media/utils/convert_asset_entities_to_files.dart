import 'dart:io';
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
    }
  }

  return files;
}
