import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraScannerOptionWidget extends StatefulWidget {
  Barcode? result;
  QRViewController? controller;

  CameraScannerOptionWidget({
    super.key,
    required this.result,
    required this.controller,
  });

  @override
  State<CameraScannerOptionWidget> createState() =>
      _CameraScannerOptionWidgetState();
}

class _CameraScannerOptionWidgetState extends State<CameraScannerOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.result != null)
              Text(
                  'Barcode Type: ${describeEnum(widget.result!.format)}   Data: ${widget.result!.code}')
            else
              const Text('Scan a code'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () async {
                        await widget.controller?.toggleFlash();
                        setState(() {});
                      },
                      child: FutureBuilder(
                        future: widget.controller?.getFlashStatus(),
                        builder: (context, snapshot) {
                          return Text('Flash: ${snapshot.data}');
                        },
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      await widget.controller?.flipCamera();
                      setState(() {});
                    },
                    child: FutureBuilder(
                      future: widget.controller?.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Text(
                              'Camera facing ${describeEnum(snapshot.data!)}');
                        } else {
                          return const Text('loading');
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      await widget.controller?.pauseCamera();
                    },
                    child: const Text('pause', style: TextStyle(fontSize: 20)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      await widget.controller?.resumeCamera();
                    },
                    child: const Text('resume', style: TextStyle(fontSize: 20)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
