// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPExternalScreen extends StatefulWidget {
  const OTPExternalScreen({Key? key}) : super(key: key);

  @override
  State<OTPExternalScreen> createState() => _OTPExternalScreenState();
}

class _OTPExternalScreenState extends State<OTPExternalScreen> {
  String _code = "";
  String signature = "{{ app signature }}";

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  _onInit() async {
    await SmsAutoFill().listenForCode();
    Future.delayed(const Duration(seconds: 5)).then((value) async {
      await SmsAutoFill().getAppSignature.then((signature) {
        setState(() {
          this.signature = signature;
          String code =
              "${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}";
          String smsMessage = "Your Verification code is : $code \n$signature";
          //send sms
          _sendSMS(smsMessage, ["+201273826361"]);
        });
      });
    });
  }

  void _sendSMS(String message, List<String> recipents) async {
    String result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(result);
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP with external package'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PinFieldAutoFill(
              decoration: UnderlineDecoration(
                textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
              currentCode: _code,
              codeLength: 4,
              onCodeSubmitted: (code) {
                if (code.length == 4) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              onCodeChanged: (code) {
                if (code!.length == 4) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            ),
            const SizedBox(height: 16.0),
            Text(_code),
            const Spacer(),
            ElevatedButton(
              child: const Text('Set code to random code'),
              onPressed: () async {
                setState(() {
                  _code =
                      "${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}";
                });
              },
            ),
            const SizedBox(height: 8.0),
            const Divider(height: 1.0),
            const SizedBox(height: 4.0),
            Text("App Signature : $signature"),
            const SizedBox(height: 4.0),
            ElevatedButton(
              child: const Text('Get app signature'),
              onPressed: () async {
                signature = await SmsAutoFill().getAppSignature;
                setState(() {});
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const CodeAutoFillTestPage()));
              },
              child: const Text("Test CodeAutoFill mixin"),
            )
          ],
        ),
      ),
    );
  }
}

class CodeAutoFillTestPage extends StatefulWidget {
  const CodeAutoFillTestPage({Key? key}) : super(key: key);

  @override
  State<CodeAutoFillTestPage> createState() => _CodeAutoFillTestPageState();
}

class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage>
    with CodeAutoFill {
  String? appSignature;
  String? otpCode;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listening for code"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              "This is the current app signature: $appSignature",
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Builder(
              builder: (_) {
                if (otpCode == null) {
                  return const Text("Listening for code...", style: textStyle);
                }
                return Text("Code Received: $otpCode", style: textStyle);
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
