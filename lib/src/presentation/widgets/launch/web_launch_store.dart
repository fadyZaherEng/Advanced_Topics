import 'dart:js' as js;

import 'package:flutter_advanced_topics/flavors.dart';

void webLaunchStore({required String platform}) async {
  String androidPackageName = '';
  String huaweiAppId = '';
  String iOSAppId = '';

  if (F.appFlavor == Flavor.production) {
    androidPackageName = "com.sprinteye.cityeye.nicetouch";
    iOSAppId = "6474612743";
    huaweiAppId = "C110578913";
  } /*else if (F.isElmanara) {
    androidPackageName = "com.sprinteye.elmanara";
    iOSAppId = "6474612743";
    huaweiAppId = "C110578913";

  }*/
  else {
    androidPackageName = "com.sprinteye.cityeye.app";
    iOSAppId = "6474612743";
    huaweiAppId = "C110578913";
  }

  String url = '';
  if (platform == 'android') {
    url = 'https://play.google.com/store/apps/details?id=$androidPackageName';
  } else if (platform == 'ios') {
    url = 'https://apps.apple.com/app/id$iOSAppId';
  } else if (platform == 'huawei') {
    url = "https://appgallery.huawei.com/app/$huaweiAppId";
  }
  js.context.callMethod('open', [url]);
}
