import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButtonWidget extends StatelessWidget {
  final String imagePath;
  final Function() onTap;

  const BackButtonWidget(
      {Key? key, required this.imagePath, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          border: Border.all(
            color: ColorSchemes.backButtonBorderGray,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: SvgPicture.asset(imagePath, matchTextDirection: true),
        ),
      ),
    );
  }
}
