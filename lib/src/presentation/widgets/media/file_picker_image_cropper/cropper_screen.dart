import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

class CropperImageScreen extends StatefulWidget {
  const CropperImageScreen({super.key});

  @override
  State<CropperImageScreen> createState() => _CropperImageScreenState();
}

class _CropperImageScreenState extends State<CropperImageScreen> {
  File? imagePicker;
  File? cropperPicker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Picker And Image Cropper"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (cropperPicker != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: Image.file(cropperPicker!),
                ),
              ),
            ),
          Center(
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () async {
                _pickImage().whenComplete(() => _cropperImage());
              },
              child: const Text("Pick Image"),
            ),
          ),
        ],
      ),
    );
  }

  Future _cropperImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePicker!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        IOSUiSettings(title: 'cropper'),
      ],
      compressQuality: 100,
      compressFormat: ImageCompressFormat.png,
      cropStyle: CropStyle.rectangle,
    );
    if (croppedFile != null) {
      cropperPicker = File(croppedFile.path);
    }
  }

  Future _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      imagePicker = File(file.path ?? "");
      setState(() {});
    }
  }
}
