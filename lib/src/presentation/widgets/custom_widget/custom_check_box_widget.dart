import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  final bool isSelected;

  const CustomCheckBoxWidget({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? ColorSchemes.primary : ColorSchemes.border,
            width: 1,
          )),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? ColorSchemes.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: SvgPicture.asset(
          ImagePaths.add,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
