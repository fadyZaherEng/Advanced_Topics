// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPSMSAutoFillScreen extends StatefulWidget {
  const OTPSMSAutoFillScreen({Key? key}) : super(key: key);

  @override
  State<OTPSMSAutoFillScreen> createState() => _OTPSMSAutoFillScreenState();
}

class _OTPSMSAutoFillScreenState extends State<OTPSMSAutoFillScreen>
    with CodeAutoFill {
  String _code = "";
  String signature = "{{ app signature }}";

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  _onInit() async {
    await SmsAutoFill().listenForCode();
  }

  //firstly get app signature then
  // send it to backend server the server will verify it
  // and send you the Sms with the code and signature
  // then this package will listen for that sms
  // and will return you the code if it is correct
  //and auto fill it in the PinField
  /*
  Sms Format
  # Your Verification code is 1234
  {{ app signature }}
   */
  void _sendCodeToPhoneNumber(String phoneNumber) async {
    await SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        this.signature = signature;
        String code =
            "${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}";
        String smsMessage = "# Your Verification code is $code \n$signature";
        //send sms
        _sendSMS(smsMessage, ["+2$phoneNumber"]);
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
        title: const Text('OTP with SMS Autofill'),
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
            const Divider(height: 1.0),
            const SizedBox(height: 4.0),
            ElevatedButton(
              child: const Text('Get Verification Code'),
              onPressed: () async {
                _sendCodeToPhoneNumber("01273826361");
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void codeUpdated() {
    setState(() {
      _code = code!;
    });
  }
}
