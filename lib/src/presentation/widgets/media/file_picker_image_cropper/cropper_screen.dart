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
          const SizedBox(
            height: 20,
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
    if (imagePicker != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePicker!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        compressQuality: 100,
        cropStyle: CropStyle.rectangle,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Cropper'),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort: const CroppieViewPort(
              width: 480,
              height: 480,
              type: 'circle',
            ),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        cropperPicker = File(croppedFile.path);
        setState(() {});
      }
    }
  }

  Future _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    try {
      if (result != null) {
        PlatformFile file = result.files.first;
        imagePicker = File(file.path ?? "");
        setState(() {});
        print(imagePicker!.path);
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }
}
