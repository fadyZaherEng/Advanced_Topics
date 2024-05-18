import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/bottom_sheet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/circular_icon.dart';

class UploadMediaWidget extends StatefulWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;

  const UploadMediaWidget({
    Key? key,
    required this.onTapCamera,
    required this.onTapGallery,
  }) : super(key: key);

  @override
  State<UploadMediaWidget> createState() => _UploadMediaWidgetState();
}

class _UploadMediaWidgetState extends State<UploadMediaWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        height: 219,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: widget.onTapGallery,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularIcon(
                      boxShadows: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            color: ColorSchemes.iconBackGround,
                            blurRadius: 24,
                            blurStyle: BlurStyle.normal,
                            spreadRadius: 5),
                      ],
                      imagePath: ImagePaths.imagesIcUploadMediaGallery,
                      backgroundColor: ColorSchemes.iconBackGround,
                      iconSize: 28),
                  const SizedBox(height: 16),
                  Text(
                    "Gallery",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 13,
                        letterSpacing: -0.24,
                        color: ColorSchemes.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 71,
            ),
            GestureDetector(
              onTap: widget.onTapCamera,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularIcon(
                      boxShadows: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            color: ColorSchemes.iconBackGround,
                            blurRadius: 24,
                            blurStyle: BlurStyle.normal,
                            spreadRadius: 5),
                      ],
                      imagePath: ImagePaths.imagesCameraProfile,
                      backgroundColor: ColorSchemes.iconBackGround,
                      iconSize: 28),
                  const SizedBox(height: 16),
                  Text(
                    "Camera",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 13,
                        letterSpacing: -0.24,
                        color: ColorSchemes.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        titleLabel: "Upload Media");
  }
}
