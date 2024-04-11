import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';

import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  F.apiEndpoint = {
    Endpoints.items: "flutterjunction.api.dev/items",
    Endpoints.details: "flutterjunction.api.dev/item"
  };
  F.imageLocation = ImagePaths.apple;
  F.theme = ThemeData.light().copyWith(
    primaryColor: const Color(0xFF123456),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor: const Color(0xFF654321),
        ),
  );
  ChuckerFlutter.showNotification = true;
  ChuckerFlutter.showOnRelease = true;
  F.appFlavor = Flavor.development;
  await runner.main();
}
