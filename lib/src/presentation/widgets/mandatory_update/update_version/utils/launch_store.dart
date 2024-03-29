import 'dart:io';

import 'package:flutter_advanced_topics/flavors.dart';
import 'package:url_launcher/url_launcher.dart';

void launchStore() async {
  String androidPackageName = F.appFlavor == Flavor.production
      ? 'com.sprinteye.cityeyehandyman.nicetouch'
      : 'com.sprinteye.cityeyehandyman';
  String iOSAppId = '6474612743';
  if (Platform.isAndroid) {
    final url =
        'https://play.google.com/store/apps/details?id=$androidPackageName';
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {}
  } else if (Platform.isIOS) {
    final url = 'https://apps.apple.com/app/id$iOSAppId';
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {}
  }
}
