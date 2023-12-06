import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInformation {
  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      _getDeviceAndroidInformation();
    } else if (Platform.isIOS) {
      _getDeviceIosInformation();
    }
  }

  Future<void> _getDeviceAndroidInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  }

  Future<void> _getDeviceIosInformation() async {
    DeviceInfoPlugin deviceInformation = DeviceInfoPlugin();
    IosDeviceInfo iosInformation = await deviceInformation.iosInfo;
  }
}
