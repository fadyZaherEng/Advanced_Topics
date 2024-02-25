import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _poweredByAnimation;
  late Animation<Offset> _powerLeftAnimation;
  late Animation<Offset> _powerRightAnimation;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initAnimation();
    await Future.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.onBoardingScreen,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ColorSchemes.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: PopScope(
        canPop: true,
        onPopInvoked: (bool? value) {
          //handle back button
        },
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SizedBox(
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: ClipOval(
                                  child: Image.asset(
                                    ImagePaths.onBoardingDoc,
                                    width: 160,
                                    height: 160,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: ColorSchemes.iconBackGround,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Text(
                                "Welcome To Clinic",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: ColorSchemes.black,
                                      fontWeight: Constants.fontWeightMedium,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 102,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.3,
                  right: 0,
                  left: 0,
                  child: SlideTransition(
                    position: _powerLeftAnimation,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "poweredBy",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: ColorSchemes.gray,
                                  letterSpacing: -0.24,
                                ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Doc ",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: ColorSchemes.black,
                                  letterSpacing: -0.24,
                                ),
                          )
                        ]),
                  )),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SlideTransition(
                  position: _powerRightAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Image.asset(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      ImagePaths.splashScreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.stop(canceled: true);
    _animationController.dispose();
    super.dispose();
  }

  Future<void> initAnimation() async {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2300,
      ),
    )..repeat(
        reverse: true,
      );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(
        0.0,
        0.5,
      ),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _poweredByAnimation = Tween<Offset>(
      begin: const Offset(
        0.0,
        1,
      ),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _powerLeftAnimation = Tween<Offset>(
      begin: const Offset(
        -1,
        0,
      ),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _powerRightAnimation = Tween<Offset>(
      begin: const Offset(
        1,
        0,
      ),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
    // Future.delayed(const Duration(seconds: 2), () {
    //   // if (!mounted) return;
    //   _animationController.reverse();
    // });
  }
}
