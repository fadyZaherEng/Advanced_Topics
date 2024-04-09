import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/constants.dart';

class SkipButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final String buttonTitle;
  final double height;
  final double? width;
  final Color borderColor;

  const SkipButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonTitle,
    this.height = 44,
    this.width,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorSchemes.primary,
                  fontWeight: Constants.fontWeightMedium,
                ),
          ),
        ),
      ),
    );
  }
}
