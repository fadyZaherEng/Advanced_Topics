import 'package:flutter/material.dart';

enum Flavor {
  development,
  staging,
  production,
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
        return 'Development Flavor';
      case Flavor.staging:
        return 'Staging Flavor';
      case Flavor.production:
        return 'Production Flavor';
      default:
        return 'title';
    }
  }
}
