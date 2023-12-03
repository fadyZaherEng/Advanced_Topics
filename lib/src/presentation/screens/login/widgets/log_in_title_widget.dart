import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_topics/src/config/theme/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTitleWidget extends StatefulWidget {
  const LoginTitleWidget({super.key});

  @override
  State<LoginTitleWidget> createState() => _LoginTitleWidgetState();
}

class _LoginTitleWidgetState extends State<LoginTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Welcome Back',
            style: TextStyles.font24BlueBold,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8.h),
          Text(
            'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
            style: TextStyles.font15GrayRegular,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 36.h),
        ]);
  }
}
