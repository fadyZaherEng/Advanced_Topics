import 'package:flutter/material.dart';
import "package:flutter_advanced_topics/main.dart" as runner;
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';

import 'flavor.dart';

Future<void> main() async {
  F.apiEndpoint = {
    Endpoints.items: "flutterjunction.api.dev/items",
    Endpoints.details: "flutterjunction.api.dev/item"
  };
  F.imageLocation = ImagePaths.face;
  F.theme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xFF856134),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor: const Color(0xFF963145),
        ),
  );
  F.appFlavor = Flavor.production;
  await runner.main();
}
