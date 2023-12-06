import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/home/home_screen.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/log_up/log_up_screen.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/login_screen.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/onBoarding/onboarding_screen.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/full_video_screen/full_video_screen.dart';

class AppRoutes {
  static const String onBoardingScreen = "/onBoardingScreen";
  static const String loginScreen = "/loginScreen";
  static const String homeScreen = "/homeScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String logUpScreen = "/logUpScreen";
  static const String fullVideoScreen = "/fullVideoScreen";
//static const String splashScreen = "/splashScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.onBoardingScreen:
        return _materialRoute(const OnBoardingScreen());
      case AppRoutes.loginScreen:
        return _materialRoute(const LogInScreen());
      case AppRoutes.homeScreen:
        return _materialRoute(const HomeScreen(title: "home"));
      // case AppRoutes.forgetPasswordScreen:
      //   return _materialRoute(const ForgetPasswordScreen());
      case AppRoutes.logUpScreen:
        return _materialRoute(const LogUpScreen());
      case AppRoutes.fullVideoScreen:
        final videoUrl = routeSettings.arguments as String;
        return _materialRoute(FullVideoScreen(videoUrl: videoUrl));
      // case AppRoutes.splashScreen:
      //   return _materialRoute(const SplashScreen());
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
