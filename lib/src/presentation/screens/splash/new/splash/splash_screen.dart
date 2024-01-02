import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  bool _isRememberMe = false;
  bool _isRestart = false;
  bool _hasInitialized = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
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

    _animationController.forward();
    //
    // _isRememberMe = GetRememberMeUseCase(injector())();
    //     false;
    // _isRestart = GetRestartAppUseCase(injector())();
    // if (!_hasInitialized) {
    //   _hasInitialized = true;
    //   if (_isRestart) {
    //     await SetRestartAppUseCase(injector())(false);
    //     await Future.delayed(const Duration(seconds: 3), () {
    //       if (!mounted) return;
    //       Navigator.pushNamedAndRemoveUntil(
    //         context,
    //         Routes.main,
    //         (route) => false,
    //       );
    //     });
    //   } else {
    //     if (_isRememberMe) {
    //       await Future.delayed(const Duration(seconds: 3), () {
    //         if (!mounted) return;
    //         Navigator.pushNamedAndRemoveUntil(
    //           context,
    //           Routes.main,
    //           (route) => false,
    //         );
    //       });
    //     } else {
    //       RemoveUserInformationUseCase(injector())();
    //       await Future.delayed(const Duration(seconds: 3), () {
    //         if (!mounted) return;
    //         Navigator.pushNamedAndRemoveUntil(
    //           context,
    //           Routes.login,
    //           (route) => false,
    //         );
    //       });
    //     }
    //   }
    // }
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Image.asset(
                          ImagePaths.google,
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
                            "", //S.of(context).stayConnectedStaySmarter,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
              ),
              Positioned(
                  bottom: 150,
                  right: 0,
                  left: 0,
                  child: SlideTransition(
                    position: _poweredByAnimation,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "", // S.of(context).poweredBy,
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
                            "", // S.of(context).cityEye,
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
                  position: _slideAnimation,
                  child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SvgPicture.asset(
                        width: MediaQuery.sizeOf(context).width,
                        ImagePaths.splashScreen,
                      )),
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
}
