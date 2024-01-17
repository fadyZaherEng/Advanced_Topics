import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

/// [DynamicLinkService]
class DynamicLinkService {
  static final DynamicLinkService _singleton = DynamicLinkService._internal();
  DynamicLinkService._internal();
  static DynamicLinkService get instance => _singleton;

  // Create new dynamic link
  void createDynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://flutteradvancedtopics.page.link.com/test"),
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

//mainfest code
// <meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
//
// <intent-filter android:autoVerify="true">
// <action android:name="android.intent.action.VIEW" />
// <category android:name="android.intent.category.DEFAULT" />
// <category android:name="android.intent.category.BROWSABLE" />
// <data android:scheme="http" android:host="flutteradvancedtopics.page.link" />
// <data android:scheme="https" />
// </intent-filter>
