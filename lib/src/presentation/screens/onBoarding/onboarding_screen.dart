// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/onBoarding/widget/onboarding_body_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/onBoarding/widget/onboarding_logo_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends BaseStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends BaseState<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    print("initState");
  }

  @override
  void didUpdateWidget(covariant OnBoardingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 20.h,
              top: 20.h,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: const OnBoardingLogoWidget(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const OnBoardingBodyWidget(),
                SizedBox(
                  height: 10.h,
                ),
                CustomButtonWidget(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.loginScreen,
                      (route) => false,
                    );
                  },
                  title: "Get Started",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
