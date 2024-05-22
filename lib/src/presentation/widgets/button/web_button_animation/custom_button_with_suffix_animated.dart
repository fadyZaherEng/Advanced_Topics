import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_with_prefix_icon_widget.dart';

class CustomButtonWithSuffixAnimated extends StatefulWidget {
  const CustomButtonWithSuffixAnimated({Key? key}) : super(key: key);

  @override
  State<CustomButtonWithSuffixAnimated> createState() => _State();
}

class _State extends State<CustomButtonWithSuffixAnimated> {
  bool _isCursorsEnterCall = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _isCursorsEnterCall = true;
        setState(() {});
      },
      onExit: (_) {
        _isCursorsEnterCall = false;
        setState(() {});
      },
      child: Stack(
        children: [
          Container(
            height: 48,
            width: 148,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: _isCursorsEnterCall,
              child: Container(
                height: 40,
                width: 148,
                decoration: BoxDecoration(
                  color: ColorSchemes.primary.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            bottom: 4,
            left: 4,
            right: 4,
            child: CustomButtonWithPrefixIconWidget(
              backgroundColor: ColorSchemes.primary,
              text: "+201062131541",
              onTap: () {},
              height: 40,
              width: 140,
              svgIcon: ImagePaths.icCall,
              isAnimated: true,
            ),
          ),
        ],
      ),
    );
  }
}
