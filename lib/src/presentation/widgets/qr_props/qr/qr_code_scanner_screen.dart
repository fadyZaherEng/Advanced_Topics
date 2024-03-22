import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/qr_props/qr/widget/build_qr_view_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/qr_props/qr/widget/camera_scanner_option_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScannerScreen extends StatefulWidget {
  const QrCodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: BuildQrViewWidget(
              result: result,
              controller: controller,
            ),
          ),
          //option in  camera scanner
          CameraScannerOptionWidget(
            result: result,
            controller: controller,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
