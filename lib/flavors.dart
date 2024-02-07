import 'package:flutter/material.dart';

enum Flavor {
  development,
  production,
  staging,
}

enum Endpoints { items, details }

class F {
  static Flavor? appFlavor;
  static Map<Endpoints, String>? apiEndpoint;
  static String? imageLocation;
  static ThemeData? theme;
  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Doc Doc Development';
      case Flavor.production:
        return 'Doc Doc Production';
      case Flavor.staging:
        return 'Doc Doc Staging';
      default:
        return 'title';
    }
  }
}
