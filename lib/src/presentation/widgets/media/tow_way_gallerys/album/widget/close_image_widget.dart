import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CloseImagesWidget extends StatefulWidget {
  const CloseImagesWidget({super.key});

  @override
  State<CloseImagesWidget> createState() => _CloseImagesWidgetState();
}

class _CloseImagesWidgetState extends State<CloseImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.5),
          ),
          child: SvgPicture.asset(
            height: 20,
            width: 20,
            ImagePaths.close,
            color: ColorSchemes.white,
          ),
        ),
      ),
    );
  }
}
