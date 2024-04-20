import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';

class QrCreateScreen extends BaseStatefulWidget {
  const QrCreateScreen({super.key});

  @override
  BaseState<QrCreateScreen> baseCreateState() => _QrCreateScreenState();
}

class _QrCreateScreenState extends BaseState<QrCreateScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Generator'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BarcodeWidget(
              barcode: Barcode.qrCode(
                errorCorrectLevel: BarcodeQRCorrectionLevel.high,
              ),
              data: 'https://pub.dev/packages/barcode_widget',
              width: 200,
              height: 200,
            ),
            Container(
              color: Colors.white,
              width: 60,
              height: 60,
              child: const FlutterLogo(),
            ),
          ],
        ),
      ),
    );
  }
}
