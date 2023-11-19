import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingLogoWidget extends StatefulWidget {
  const OnBoardingLogoWidget({super.key});

  @override
  State<OnBoardingLogoWidget> createState() => _OnBoardingLogoWidgetState();
}

class _OnBoardingLogoWidgetState extends State<OnBoardingLogoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          ImagePaths.onBoardingLogo,
          color: Colors.deepPurple,
          width: 38.w,
          height: 38.h,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          "Docdoc",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
