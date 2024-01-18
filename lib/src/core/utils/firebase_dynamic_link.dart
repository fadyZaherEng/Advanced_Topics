import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  DynamicLinkService._();
  static final DynamicLinkService _instance = DynamicLinkService._();
  static DynamicLinkService get getInstance => _instance;

  // Create new dynamic link
  void createDynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://flutteradvancedtopics.page.link/test1"),
      uriPrefix: "https://flutteradvancedtopics.page.link",
      androidParameters: const AndroidParameters(
          packageName: "com.example.flutter_advanced_topics"),
      iosParameters: const IOSParameters(
          bundleId: "com.example.flutter_advanced_topics",
          appStoreId: "123456789"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    debugPrint("${dynamicLink.shortUrl}");
  }
}
