import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileContentBottomSheetWidget extends StatefulWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;
  final Function() onTapFile;

  const FileContentBottomSheetWidget(
      {super.key,
      required this.onTapCamera,
      required this.onTapGallery,
      required this.onTapFile});

  @override
  State<FileContentBottomSheetWidget> createState() =>
      _FileContentBottomSheetWidgetState();
}

class _FileContentBottomSheetWidgetState
    extends State<FileContentBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: widget.onTapCamera,
          child: Row(
            children: [
              SvgPicture.asset(
                ImagePaths.imagesIcCamera,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 10),
              Text(
                "Camera",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorSchemes.black,
                    ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Divider(height: 1, color: ColorSchemes.black),
        const SizedBox(height: 15),
        InkWell(
          onTap: widget.onTapGallery,
          child: Row(
            children: [
              SvgPicture.asset(
                ImagePaths.imagesIcGallary,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 10),
              Text(
                "Gallery",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorSchemes.black,
                    ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Divider(height: 1, color: ColorSchemes.black),
        const SizedBox(height: 15),
        InkWell(
          onTap: widget.onTapFile,
          child: Row(
            children: [
              SvgPicture.asset(
                ImagePaths.imagesIcFile,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 10),
              Text(
                "File",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorSchemes.black,
                    ),
              )
            ],
          ),
        )
      ],
    );
  }
}
