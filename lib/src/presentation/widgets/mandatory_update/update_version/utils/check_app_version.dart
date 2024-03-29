// ignore_for_file: empty_catches

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/flavors.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mandatory_update/update_version/utils/show_update_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version_check/version_check.dart';

Future<void> checkVersion({
  required BuildContext context,
  required bool isMandatory,
}) async {
  final versionCheck = VersionCheck(
    packageName: F.appFlavor == Flavor.production
        ? 'com.sprinteye.cityeyehandyman.nicetouch'
        : 'com.sprinteye.cityeyehandyman',
    showUpdateDialog: (context, version) =>
        CheckAppVersion.customShowUpdateDialog(context, isMandatory),
  );
  await versionCheck.checkVersion(context);
}

class CheckAppVersion {
  static void customShowUpdateDialog(
      BuildContext context, bool isMandatory) async {
    await showUpdateDialog(
      context: context,
      isMandatory: isMandatory,
    );
  }

  static bool checkForceUpdate(String packageVersion, String minVersion) {
    final currentVersion = packageVersion.split('.');
    final minVersion0 = minVersion.split('.');

    for (int i = 0;
        i < math.min(currentVersion.length, minVersion0.length);
        i++) {
      final int? v1 = int.tryParse(currentVersion[i]);
      final int? v2 = int.tryParse(minVersion0[i]);

      if (v1 == null || v2 == null) {
        if (minVersion0[i].compareTo(currentVersion[i]) > 0) {
          return true;
        } else if (minVersion0[i].compareTo(currentVersion[i]) < 0) {
          return false;
        }
      } else if (v2 < v1) {
        return true;
      } else if (v2 > v1) {
        return false;
      }
    }

    if (minVersion0.length < currentVersion.length) return true;

    return true;
  }

  static String getMinVersion(String storeVersion) {
    final storeVersion0 = storeVersion.split('.').map(int.parse).toList();

    while (storeVersion0.length < 3) {
      storeVersion0.add(0);
    }

    storeVersion0[storeVersion0.length - 1] -= 2;

    for (int i = storeVersion0.length - 1; i > 0; i--) {
      if (storeVersion0[i] < 0) {
        storeVersion0[i] += 10;
        storeVersion0[i - 1] -= 1;
      }
    }

    final minVersion = storeVersion0.join('.');

    return minVersion;
  }
}
