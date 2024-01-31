import 'package:flutter/material.dart';
import "package:flutter_advanced_topics/main.dart" as runner;
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';

import 'src/presentation/widgets/flutter_flavorizr/flavors.dart';

Future<void> main() async {
  F.imageLocation = ImagePaths.google;
  F.appFlavor = Flavor.staging;
  F.theme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xFF856896),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor: const Color(0xFF963277),
        ),
  );
  await runner.main();
}
