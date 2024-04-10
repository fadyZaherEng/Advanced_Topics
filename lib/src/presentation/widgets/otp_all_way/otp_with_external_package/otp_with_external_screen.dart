import 'package:flutter/material.dart';

class ExternalOtpScreen extends StatefulWidget {
  const ExternalOtpScreen({super.key});

  @override
  State<ExternalOtpScreen> createState() => _ExternalOtpScreenState();
}

class _ExternalOtpScreenState extends State<ExternalOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP'),
      ),
      body: Container(),
    );
  }
}
