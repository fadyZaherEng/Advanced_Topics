import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BuildQrViewWidget extends StatefulWidget {
  Barcode? result;
  QRViewController? controller;

  BuildQrViewWidget({
    super.key,
    required this.result,
    required this.controller,
  });

  @override
  State<BuildQrViewWidget> createState() => _BuildQrViewWidgetState();
}

class _BuildQrViewWidgetState extends State<BuildQrViewWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      widget.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        widget.result = scanData;
        controller.pauseCamera();
        controller.resumeCamera();
        print(widget.result);
      });
      if (widget.result!.code!.isNotEmpty) {
        onQrCodeScanned(widget.result?.code ?? "");
      }
    });
  }

  void onQrCodeScanned(String s) {
    //send to api
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
