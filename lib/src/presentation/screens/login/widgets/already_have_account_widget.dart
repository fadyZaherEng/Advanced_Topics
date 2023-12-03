import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/config/theme/font_weight_helper.dart';
import 'package:flutter_advanced_topics/src/config/theme/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlreadyHaveAccountTextWidget extends StatelessWidget {
  void Function() onSignUpPressed;
  AlreadyHaveAccountTextWidget({
    super.key,
    required this.onSignUpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSignUpPressed,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account?',
              style: TextStyles.font13DarkBlueRegular,
            ),
            TextSpan(
              text: ' Sign Up',
              style: TextStyles.font14DarkBlueMedium.copyWith(
                color: ColorSchemes.primary,
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
