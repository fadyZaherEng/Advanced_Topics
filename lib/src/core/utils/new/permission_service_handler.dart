import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class PermissionServiceHandler {
  Future<bool> handleServicePermission({required Permission setting}) async {
    await setting.status;
    final result = await setting.request();

    switch (result) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
      default:
        return false;
    }
  }

  static Permission getCameraPermission() {
    return Permission.camera;
  }

  static Permission getGalleryPermission(bool isMultiple,
      {AndroidDeviceInfo? androidDeviceInfo}) {
    if (isMultiple) {
      return getMultipleImageGalleryPermission(
          androidDeviceInfo: androidDeviceInfo);
    }

    return getSingleImageGalleryPermission();
  }

  static Permission getSingleImageGalleryPermission() {
    return Permission.storage;
  }

  static Permission getMultipleImageGalleryPermission({
    AndroidDeviceInfo? androidDeviceInfo,
  }) {
    if (Platform.isAndroid) {
      return androidDeviceInfo!.version.sdkInt >= 33
          ? Permission.photos
          : Permission.storage;
    } else {
      return Permission.photos;
    }
  }

  static Permission getSingleVideoGalleryPermission(
      {AndroidDeviceInfo? androidDeviceInfo}) {
    return Permission.camera;
  }

  static Permission getMicrophonePermission() {
    return Permission.microphone;
  }

  static Permission getStorageFilesPermission(
      {AndroidDeviceInfo? androidDeviceInfo}) {
    if (Platform.isAndroid) {
      return androidDeviceInfo!.version.sdkInt >= 33
          ? Permission.photos
          : Permission.storage;
    } else {
      return Permission.storage;
    }
  }

  static Permission getCalendarPermission() {
    return Permission.calendarFullAccess;
  }
}
