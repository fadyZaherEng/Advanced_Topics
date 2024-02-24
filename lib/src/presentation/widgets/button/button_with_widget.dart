import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonWithWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isSuffixIcon;
  final Function() onPressed;

  const ButtonWithWidget({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.isSuffixIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: ColorSchemes.primary,
            elevation: 0,
            side: const BorderSide(color: ColorSchemes.buttonBorderGray),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isSuffixIcon)
                SvgPicture.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                ),
              if (!isSuffixIcon) const SizedBox(width: 8),
              Text(title),
              if (isSuffixIcon) const SizedBox(width: 6),
              if (isSuffixIcon)
                SvgPicture.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                  matchTextDirection: true,
                ),
            ],
          )),
    );
  }
}
