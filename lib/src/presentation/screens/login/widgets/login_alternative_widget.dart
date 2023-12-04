// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginAlternativeWidget extends StatefulWidget {
  const LoginAlternativeWidget({super.key});

  @override
  State<LoginAlternativeWidget> createState() => _LoginAlternativeWidgetState();
}

class _LoginAlternativeWidgetState extends State<LoginAlternativeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.grey.withOpacity(0.1),
          child: SvgPicture.asset(
            ImagePaths.google,
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(width: 25.w),
        CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.grey.withOpacity(0.1),
          child: SvgPicture.asset(
            ImagePaths.face,
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(width: 25.w),
        CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.grey.withOpacity(0.1),
          child: SvgPicture.asset(
            ImagePaths.apple,
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}
