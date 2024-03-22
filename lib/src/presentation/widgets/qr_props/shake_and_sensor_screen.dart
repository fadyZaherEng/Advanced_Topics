import 'dart:async';

import 'package:country_ip/country_ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/internet/set_no_internet_use_case.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/qr_props/badge_identity/badge_identity_screen.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShakeScreen extends StatefulWidget {
  const ShakeScreen({super.key});
  @override
  State<ShakeScreen> createState() => _ShakeScreenState();
}

class _ShakeScreenState extends State<ShakeScreen> with WidgetsBindingObserver {
  late StreamSubscription<UserAccelerometerEvent> shakeAppListener;
  List<double> accelerationValues = List.filled(3, 2.0);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _shakeAppListener();
    _getCurrentCountryCode();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) async {
    super.didChangeAppLifecycleState(appLifecycleState);
    if (appLifecycleState == AppLifecycleState.resumed) {
      _shakeAppListener();
      await SetCanNavigateToBadgeScreenUseCase(injector())(true);
    } else if (appLifecycleState == AppLifecycleState.paused) {
      await shakeAppListener.cancel();
      await SetCanNavigateToBadgeScreenUseCase(injector())(false);
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await SetNoInternetUseCase(injector())(false);
    WidgetsBinding.instance.removeObserver(this);
  }

  void _getCurrentCountryCode() async {
    final countryIpResponse = await CountryIp.find();
    // await SaveCurrentCountryCodeUseCase(injector())(
    //     countryIpResponse?.countryCode ?? "EG");
  }

  void _shakeAppListener() async {
    await SetCanNavigateToBadgeScreenUseCase(injector())(true);
    shakeAppListener = userAccelerometerEventStream(
      samplingPeriod: const Duration(milliseconds: 500),
    ).listen((UserAccelerometerEvent event) {
      accelerationValues = <double>[event.x, event.y, event.z];
      if (isShake(accelerationValues)) {
        _handleShake();
      }
    });
  }

  bool isShake(List<double> values) {
    const double shakeThreshold = 30;
    double acceleration = values.reduce((sum, value) => sum + value.abs());
    return acceleration > shakeThreshold;
  }

  void _handleShake() async {
    setState(() {});
    if (GetCanNavigateToBadgeScreenUseCase(injector())()) {
      await SetCanNavigateToBadgeScreenUseCase(injector())(false).then(
        (value) => Navigator.pushNamed(
          context,
          AppRoutes.badgeIdentityScreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Shake Screen"),
      ),
    );
  }
}

class GetCanNavigateToBadgeScreenUseCase {
  final SharedPreferences sharedPreferences;

  GetCanNavigateToBadgeScreenUseCase(this.sharedPreferences);

  bool call() {
    return sharedPreferences.getBool("isNavigationToBadge") ?? true;
  }
}
