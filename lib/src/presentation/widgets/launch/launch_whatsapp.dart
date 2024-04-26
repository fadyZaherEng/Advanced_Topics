import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchWhatsAppScreen extends StatefulWidget {
  const LaunchWhatsAppScreen({super.key});

  @override
  State<LaunchWhatsAppScreen> createState() => _LaunchWhatsAppScreenState();
}

class _LaunchWhatsAppScreenState extends State<LaunchWhatsAppScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void launchWhatsApp(String phoneNumber, String message) async {
    String whatsappUrl =
        "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";
    try {
      await launchUrlString(whatsappUrl);
    } catch (e) {
      if (Platform.isAndroid) {
        String url =
            "https://play.google.com/store/apps/details?id=com.whatsapp";
        await launch(url);
      } else if (Platform.isIOS) {
        String url =
            "https://apps.apple.com/app/whatsapp-messenger/id310633997";
        await launch(url);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to open what's app"),
            ),
          );
        }
      }
    }
  }
}
