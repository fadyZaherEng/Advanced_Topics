import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonWithIconWidget extends StatelessWidget {
  final Function onTap;
  final String buttonTitle;
  final String icon;
  final Color backgroundColor;
  final Color titleColor;
  final Color iconColor;

  const ButtonWithIconWidget({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    required this.icon,
    this.backgroundColor = ColorSchemes.primary,
    this.titleColor = ColorSchemes.white,
    this.iconColor = ColorSchemes.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side:
                      const BorderSide(color: ColorSchemes.buttonBorderGray))),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: ColorSchemes.buttonBorderGray, width: 0),
          ),
        ),
        icon: SvgPicture.asset(
          height: 26,
          width: 26,
          icon,
          color: iconColor,
        ),
        onPressed: () => onTap(),
        label: Text(
          buttonTitle,
          style: TextStyle(
            color: titleColor,
            fontSize: 15,
            letterSpacing: -0.26,
            fontFamily: "englishFontFamily",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
