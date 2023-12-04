import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordWidget extends StatefulWidget {
  void Function() onForgetPasswordPressed;
  ForgetPasswordWidget({
    super.key,
    required this.onForgetPasswordPressed,
  });

  @override
  State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(
                value: _rememberMe,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: ColorSchemes.primary,
                side: const BorderSide(
                  color: ColorSchemes.gray,
                  width: 1,
                ),
                onChanged: (value) {
                  setState(
                    () {
                      _rememberMe = value!;
                    },
                  );
                },
              ),
              SizedBox(width: 0.w),
              const Text(
                "Remember me",
                style: TextStyle(
                  color: ColorSchemes.gray,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: widget.onForgetPasswordPressed,
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                color: ColorSchemes.primary,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }
}
