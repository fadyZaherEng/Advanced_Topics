import 'dart:io';
import 'dart:typed_data';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<List<File>> convertAssetsToFiles(List<Asset> assets) async {
  List<File> files = [];

  for (Asset asset in assets) {

    final ByteData byteData = await asset.getByteData(quality: 50);
    final List<int> buffer = byteData.buffer.asUint8List();
    final String tempDir = (await getTemporaryDirectory()).path;
    final String tempFileName = '$tempDir/${asset.name}';

    final File file = File(tempFileName);
    await file.writeAsBytes(buffer);
    // XFile? imageFile = await compressFile(file);

    files.add(File(file.path));
  }
  return files;
}


