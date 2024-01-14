import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';

class CustomButtonInternetWidget extends StatelessWidget {
  final void Function() onTap;
  final List<TextEditingController>? controllers;
  final String text;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double height;
  final double? width;
  final double buttonBorderRadius;
  final FontWeight fontWeight;
  final bool isPrefixIcon;
  final Widget prefixIcon;
  final TextStyle? customTextStyle;
  final double spaceBetweenIconAndText;
  final bool isWantPutPaddingInTextAndIconOrOther;
  final EdgeInsets paddingWantPutPaddingInTextAndIconOrOther;

  const CustomButtonInternetWidget({
    Key? key,
    this.controllers = const [],
    required this.onTap,
    required this.text,
    this.backgroundColor = ColorSchemes.primary,
    this.textColor = ColorSchemes.white,
    this.height = 48,
    this.width,
    this.borderColor = Colors.transparent,
    this.buttonBorderRadius = 12,
    this.fontWeight = Constants.fontWeightSemiBold,
    this.isPrefixIcon = false,
    this.prefixIcon = const SizedBox.shrink(),
    this.fontSize = 16.0,
    this.customTextStyle,
    this.spaceBetweenIconAndText = 12.0,
    this.isWantPutPaddingInTextAndIconOrOther = false,
    this.paddingWantPutPaddingInTextAndIconOrOther = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 102.0),
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
        onPressed: onTap,
        child: isPrefixIcon
            ? Padding(
                padding: isWantPutPaddingInTextAndIconOrOther
                    ? paddingWantPutPaddingInTextAndIconOrOther
                    : EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    prefixIcon,
                    SizedBox(
                      width: spaceBetweenIconAndText,
                    ),
                    Text(
                      text,
                      style: customTextStyle ??
                          Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: textColor,
                                letterSpacing: 0.24,
                                fontWeight: fontWeight,
                                fontSize: fontSize,
                              ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: isWantPutPaddingInTextAndIconOrOther
                    ? paddingWantPutPaddingInTextAndIconOrOther
                    : EdgeInsets.zero,
                child: Text(
                  text,
                  style: customTextStyle ??
                      Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: textColor,
                            fontSize: fontSize,
                            letterSpacing: 0.24,
                            fontWeight: fontWeight,
                          ),
                ),
              ),
      ),
    );
  }
}
