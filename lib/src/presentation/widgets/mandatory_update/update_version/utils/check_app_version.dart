import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/flavors.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mandatory_update/update_version/utils/show_update_dialog.dart';
import 'package:version_check/version_check.dart';

Future<void> checkVersion({
  required BuildContext context,
  required bool isMandatory,
  required Function() onTapUpdate,
  required Function() onSkipTab,
}) async {
  final versionCheck = VersionCheck(
    packageName: Flavor.production == F.appFlavor
        ? 'com.sprinteye.cityeyehandyman.nicetouch'
        : 'com.sprinteye.cityeyehandyman',
    showUpdateDialog: (context, version) {
      showUpdateDialog(
        context: context,
        isMandatory: isMandatory,
        onTapUpdate: onTapUpdate,
        onSkipTab: onSkipTab,
      );
    },
    country: "US",
  );
  await versionCheck.checkVersion(context);
}
