import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/web_animated/web_animated_svg_icon.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonWithPrefixIconWidget extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double? height;
  final double? width;
  final double borderWidth;
  final double buttonBorderRadius;
  final FontWeight fontWeight;
  final TextStyle? textStyle;
  final String svgIcon;
  final bool isAnimated;

  const CustomButtonWithPrefixIconWidget({
    Key? key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    required this.svgIcon,
    this.isAnimated = false,
    this.textColor = ColorSchemes.white,
    this.height = 48,
    this.width,
    this.borderWidth = 1,
    this.borderColor = Colors.transparent,
    this.buttonBorderRadius = 12,
    this.fontWeight = Constants.fontWeightSemiBold,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                  letterSpacing: 0.24,
                  fontWeight: fontWeight,
                ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
        onPressed: onTap,
        child: Row(
          children: [
            isAnimated
                ? AnimatedSvgIcon(
                    svgIcon: svgIcon,
                    width: 16,
                    height: 16,
                  )
                : SvgPicture.asset(
                    svgIcon,
                    width: 16,
                    height: 16,
                    color: textColor,
                  ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: textStyle ??
                    Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: textColor,
                          letterSpacing: 0.24,
                          fontWeight: fontWeight,
                        ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
