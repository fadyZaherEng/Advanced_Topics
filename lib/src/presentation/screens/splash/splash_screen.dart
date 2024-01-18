import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';

class SplashScreenOld extends StatefulWidget {
  const SplashScreenOld({Key? key}) : super(key: key);

  @override
  State<SplashScreenOld> createState() => _SplashScreenOldState();
}

class _SplashScreenOldState extends State<SplashScreenOld> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          ImagePaths.splashScreen,
        ),
      ),
    );
  }

  void _navigateToMainScreen() {
    if (mounted) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.onBoardingScreen, (route) => false));
    }
  }
}
