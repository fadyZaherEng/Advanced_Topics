import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/login_screen.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/onBoarding/onboarding_screen.dart';

class Routes {
  static const String onBoardingScreen = "/onBoardingScreen";
  static const String loginScreen = "loginScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.onBoardingScreen:
        return _materialRoute(const OnBoardingScreen());
      case Routes.loginScreen:
        return _materialRoute(const LogInScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Not found")),
        body: const Center(
          child: Text("Not found"),
        ),
      ),
    );
  }
}
