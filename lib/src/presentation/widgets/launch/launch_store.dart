import 'dart:io';

import 'package:flutter_advanced_topics/flavors.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:url_launcher/url_launcher.dart';

void launchStore() async {
  String androidPackageName = F.appFlavor == Flavor.production
      ? 'com.sprinteye.cityeyehandyman.nicetouch'
      : 'com.sprinteye.cityeyehandyman';
  if (Platform.isIOS) {
    String iOSAppId = '6479604068';
    final url = 'https://apps.apple.com/app/id$iOSAppId';
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
    }
  } else {
    if (await HmsApiAvailability().isHMSAvailableWithApkVersion(28) != 1) {
      String huaweiAppId = 'C110577713';
      final url = "https://appgallery.huawei.com/app/$huaweiAppId";
      try {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } catch (e) {
        print(e);
      }
    } else {
      final url =
          'https://play.google.com/store/apps/details?id=$androidPackageName';
      try {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } catch (e) {
        print(e);
      }
    }
  }
}
