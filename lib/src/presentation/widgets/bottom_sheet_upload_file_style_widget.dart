import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomSheetFileStyleOfContentWidget extends StatelessWidget {
  final Widget content;
  final String titleLabel;
  final double height;
  final bool isTitleVisible;

  const BottomSheetFileStyleOfContentWidget({
    Key? key,
    required this.content,
    required this.titleLabel,
    this.height = 300,
    this.isTitleVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: ColorSchemes.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      ImagePaths.close,
                      height: 16,
                      width: 16,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isTitleVisible,
              child: Text(
                titleLabel,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorSchemes.black,
                    fontSize: 18,
                    letterSpacing: -0.24),
              ),
            ),
            Visibility(
              visible: isTitleVisible,
              child: const SizedBox(height: 0),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
